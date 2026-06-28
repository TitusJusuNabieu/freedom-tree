import type { DefaultSession, DefaultUser } from "next-auth";

declare module "next-auth" {
  interface Session {
    user: DefaultSession["user"] & {
      id: string;
      role: "FIELD_WORKER" | "SUPERVISOR" | "DATA_ANALYST" | "ADMIN" | "SUPER_ADMIN";
      position: string;
      community: string | null;
      avatarUrl: string | null;
    };
  }

  interface User extends DefaultUser {
    role: "FIELD_WORKER" | "SUPERVISOR" | "DATA_ANALYST" | "ADMIN" | "SUPER_ADMIN";
    position: string;
    community: string | null;
    avatarUrl: string | null;
  }
}
