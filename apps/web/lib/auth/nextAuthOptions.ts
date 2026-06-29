import type { NextAuthOptions } from "next-auth";
import CredentialsProvider from "next-auth/providers/credentials";
import { verifyCredentials } from "@/lib/auth/verifyCredentials";

type AppRole = "FIELD_WORKER" | "SUPERVISOR" | "DATA_ANALYST" | "ADMIN" | "SUPER_ADMIN";

export const authOptions: NextAuthOptions = {
  session: { strategy: "jwt" },
  pages: { signIn: "/login" },
  providers: [
    CredentialsProvider({
      name: "Credentials",
      credentials: {
        username: { label: "Username", type: "text" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials) {
        if (!credentials?.username || !credentials?.password) return null;
        const user = await verifyCredentials(credentials.username, credentials.password);
        if (!user) return null;
        // Field workers use the mobile app only
        if (user.role === "FIELD_WORKER") return null;
        return {
          id: user.id,
          name: user.name,
          role: user.role as AppRole,
          position: user.position,
          community: user.community ?? null,
          avatarUrl: user.avatarUrl ?? null,
        };
      },
    }),
  ],
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.id = user.id;
        token.role = user.role;
        token.position = user.position;
        token.community = (user as { community?: string | null }).community ?? null;
        token.avatarUrl = (user as { avatarUrl?: string | null }).avatarUrl ?? null;
      }
      return token;
    },
    async session({ session, token }) {
      if (session.user) {
        session.user.id = token.id as string;
        session.user.role = token.role as AppRole;
        session.user.position = token.position as string;
        session.user.community = (token.community as string | null) ?? null;
        session.user.avatarUrl = (token.avatarUrl as string | null) ?? null;
      }
      return session;
    },
  },
};
