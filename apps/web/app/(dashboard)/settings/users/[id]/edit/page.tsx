"use client";

import { useState, useEffect, FormEvent } from "react";
import { useRouter, useParams } from "next/navigation";
import Link from "next/link";

const ROLES = [
  { value: "FIELD_WORKER", label: "Field Worker" },
  { value: "SUPERVISOR", label: "Supervisor" },
  { value: "DATA_ANALYST", label: "Data Analyst" },
  { value: "ADMIN", label: "Admin" },
  { value: "SUPER_ADMIN", label: "Super Admin" },
];

interface UserData {
  id: string;
  username: string;
  name: string;
  position: string;
  role: string;
  community: string | null;
  active: boolean;
}

export default function EditUserPage() {
  const router = useRouter();
  const params = useParams();
  const userId = params.id as string;

  const [user, setUser] = useState<UserData | null>(null);
  const [fetchError, setFetchError] = useState<string | null>(null);
  const [saveError, setSaveError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [loading, setLoading] = useState(false);

  const [form, setForm] = useState({
    name: "",
    position: "",
    role: "FIELD_WORKER",
    community: "",
    active: true,
    password: "",
  });

  useEffect(() => {
    fetch(`/api/users/${userId}`)
      .then((r) => r.json())
      .then((data: UserData) => {
        setUser(data);
        setForm({
          name: data.name,
          position: data.position,
          role: data.role,
          community: data.community ?? "",
          active: data.active,
          password: "",
        });
      })
      .catch(() => setFetchError("Failed to load user"));
  }, [userId]);

  function handleChange(e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) {
    const target = e.target;
    const value = target.type === "checkbox" ? (target as HTMLInputElement).checked : target.value;
    setForm((prev) => ({ ...prev, [target.name]: value }));
  }

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    setSaveError(null);
    setSuccess(false);
    setLoading(true);

    try {
      const body: Record<string, unknown> = {
        name: form.name,
        position: form.position,
        role: form.role,
        community: form.community || null,
        active: form.active,
      };
      if (form.password) body.password = form.password;

      const res = await fetch(`/api/users/${userId}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });

      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        setSaveError(data.error ?? "Failed to update user");
        return;
      }

      setSuccess(true);
      setTimeout(() => router.push("/settings/users"), 800);
    } finally {
      setLoading(false);
    }
  }

  if (fetchError) {
    return (
      <div className="mx-auto max-w-lg space-y-4">
        <p className="text-red-600">{fetchError}</p>
        <Link href="/settings/users" className="text-ft-orange hover:underline">← Back</Link>
      </div>
    );
  }

  if (!user) {
    return <div className="text-ft-grey-light">Loading…</div>;
  }

  return (
    <div className="mx-auto max-w-lg space-y-6">
      <div className="flex items-center gap-4">
        <Link href="/settings/users" className="text-ft-orange hover:underline text-sm">
          ← Back to Users
        </Link>
        <h1 className="text-2xl font-semibold text-ft-grey-dark">Edit User — {user.username}</h1>
      </div>

      {saveError && (
        <div className="rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
          {saveError}
        </div>
      )}
      {success && (
        <div className="rounded-lg border border-green-200 bg-green-50 px-4 py-3 text-sm text-green-700">
          Saved! Redirecting…
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-4 rounded-lg border border-ft-grey-light p-6">
        <Field label="Full Name" name="name" value={form.name} onChange={handleChange} required />
        <Field label="Position" name="position" value={form.position} onChange={handleChange} required />

        <div className="space-y-1">
          <label className="block text-sm font-medium text-ft-grey-dark">Role</label>
          <select
            name="role"
            value={form.role}
            onChange={handleChange}
            className="w-full rounded-lg border border-ft-grey-light px-3 py-2 text-sm focus:border-ft-orange focus:outline-none"
          >
            {ROLES.map((r) => (
              <option key={r.value} value={r.value}>{r.label}</option>
            ))}
          </select>
        </div>

        <Field label="Community (optional)" name="community" value={form.community} onChange={handleChange} />

        <div className="flex items-center gap-2">
          <input
            type="checkbox"
            id="active"
            name="active"
            checked={form.active}
            onChange={handleChange}
            className="h-4 w-4 rounded border-ft-grey-light accent-ft-orange"
          />
          <label htmlFor="active" className="text-sm font-medium text-ft-grey-dark">Active</label>
        </div>

        <Field
          label="New Password (leave blank to keep current)"
          name="password"
          type="password"
          value={form.password}
          onChange={handleChange}
        />

        <div className="flex gap-3 pt-2">
          <button
            type="submit"
            disabled={loading}
            className="rounded-lg bg-ft-orange px-6 py-2 text-sm font-medium text-white hover:opacity-90 disabled:opacity-50"
          >
            {loading ? "Saving…" : "Save Changes"}
          </button>
          <Link
            href="/settings/users"
            className="rounded-lg border border-ft-grey-light px-6 py-2 text-sm font-medium text-ft-grey-dark hover:bg-gray-50"
          >
            Cancel
          </Link>
        </div>
      </form>
    </div>
  );
}

function Field({
  label,
  name,
  value,
  onChange,
  type = "text",
  required,
}: {
  label: string;
  name: string;
  value: string;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  type?: string;
  required?: boolean;
}) {
  return (
    <div className="space-y-1">
      <label className="block text-sm font-medium text-ft-grey-dark">{label}</label>
      <input
        type={type}
        name={name}
        value={value}
        onChange={onChange}
        required={required}
        className="w-full rounded-lg border border-ft-grey-light px-3 py-2 text-sm focus:border-ft-orange focus:outline-none"
      />
    </div>
  );
}
