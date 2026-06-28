"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useSession } from "next-auth/react";

export function NavLinks() {
  const pathname = usePathname();
  const { data: session } = useSession();
  const role = session?.user?.role;

  const links = [
    { href: "/", label: "Overview" },
    { href: "/reports", label: "Reports" },
    { href: "/surveys/education", label: "Education Surveys" },
    { href: "/surveys/maternal", label: "Maternal Surveys" },
    ...(role === "SUPER_ADMIN" ? [{ href: "/settings/users", label: "Users" }] : []),
  ];

  return (
    <nav className="flex gap-4">
      {links.map((link) => {
        const active =
          link.href === "/"
            ? pathname === "/"
            : pathname.startsWith(link.href);
        return (
          <Link
            key={link.href}
            href={link.href}
            className={`text-sm font-medium ${
              active ? "text-ft-orange" : "text-ft-grey-dark hover:text-ft-orange"
            }`}
          >
            {link.label}
          </Link>
        );
      })}
    </nav>
  );
}
