import { redirect } from "next/navigation";
import { getServerSession } from "next-auth";
import Link from "next/link";
import { authOptions } from "@/lib/auth/nextAuthOptions";
import { Logo } from "@/components/Logo";
import { NavLinks } from "@/components/NavLinks";
import { SignOutButton } from "@/components/SignOutButton";

// Auth check below relies on the per-request session cookie — this route
// group must never be statically prerendered, or unauthenticated visitors
// would be served a build-time snapshot with no redirect.
export const dynamic = "force-dynamic";

export default async function DashboardLayout({ children }: { children: React.ReactNode }) {
  const session = await getServerSession(authOptions);
  if (!session?.user) {
    redirect("/login");
  }

  return (
    <div className="flex min-h-screen flex-col">
      <header className="flex items-center justify-between border-b border-ft-grey-light px-6 py-3">
        <div className="flex items-center gap-6">
          <Logo />
          <NavLinks />
        </div>
        <div className="flex items-center gap-4 text-sm text-ft-grey-dark">
          <Link href="/profile" className="flex items-center gap-2 hover:opacity-80">
            {session.user.avatarUrl ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                src={session.user.avatarUrl}
                className="h-8 w-8 rounded-full object-cover"
                alt=""
              />
            ) : (
              <span className="flex h-8 w-8 items-center justify-center rounded-full bg-ft-orange text-xs font-semibold text-white">
                {session.user.name?.charAt(0).toUpperCase()}
              </span>
            )}
            <span>{session.user.name}</span>
          </Link>
          <SignOutButton />
        </div>
      </header>
      <main className="flex-1 bg-white px-6 py-8">{children}</main>
    </div>
  );
}
