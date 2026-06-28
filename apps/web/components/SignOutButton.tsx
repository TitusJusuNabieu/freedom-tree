"use client";

import { signOut } from "next-auth/react";

export function SignOutButton() {
  return (
    <button onClick={() => signOut({ callbackUrl: "/login" })} className="font-medium text-ft-orange hover:text-ft-dark-orange">
      Sign out
    </button>
  );
}
