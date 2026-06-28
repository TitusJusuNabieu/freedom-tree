"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

export function DeactivateButton({ userId, active }: { userId: string; active: boolean }) {
  const router = useRouter();
  const [loading, setLoading] = useState(false);

  async function handleClick() {
    setLoading(true);
    try {
      await fetch(`/api/users/${userId}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ active: !active }),
      });
      router.refresh();
    } finally {
      setLoading(false);
    }
  }

  return (
    <button
      onClick={handleClick}
      disabled={loading}
      className={`text-xs hover:underline disabled:opacity-50 ${active ? "text-red-600" : "text-green-600"}`}
    >
      {active ? "Deactivate" : "Reactivate"}
    </button>
  );
}
