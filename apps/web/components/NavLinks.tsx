"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useSession } from "next-auth/react";

type Role = "FIELD_WORKER" | "SUPERVISOR" | "DATA_ANALYST" | "ADMIN" | "SUPER_ADMIN";

function buildLinks(role: Role | undefined) {
  const isAdmin = role === "ADMIN" || role === "SUPER_ADMIN";
  const isAnalyst = role === "DATA_ANALYST";
  const isSupervisor = role === "SUPERVISOR";

  const links = [
    { href: "/", label: "Overview" },
    { href: "/reports", label: "Reports" },
  ];

  if (isAdmin || isAnalyst) {
    links.push(
      { href: "/surveys/education", label: "Education Surveys" },
      { href: "/surveys/maternal", label: "Maternal Surveys" },
    );
  }

  if (isSupervisor) {
    links.push(
      { href: "/surveys/education", label: "Education Surveys" },
      { href: "/surveys/maternal", label: "Maternal Surveys" },
    );
  }

  if (isAdmin) {
    links.push({ href: "/settings/users", label: "Users" });
  }

  return links;
}

export function NavLinks() {
  const pathname = usePathname();
  const { data: session } = useSession();
  const role = session?.user?.role;

  const links = buildLinks(role);

  return (
    <nav className="flex items-center gap-4">
      {links.map((link) => {
        const active = link.href === "/" ? pathname === "/" : pathname.startsWith(link.href);
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
      {role && (
        <span className="ml-2 rounded-full border border-ft-grey-light px-2 py-0.5 text-xs text-ft-grey-medium">
          {role.replace("_", " ")}
        </span>
      )}
    </nav>
  );
}
