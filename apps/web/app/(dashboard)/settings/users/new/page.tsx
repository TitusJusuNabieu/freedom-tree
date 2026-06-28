"use client";

import { useState, FormEvent } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";

const ROLES = [
  { value: "FIELD_WORKER", label: "Field Worker" },
  { value: "SUPERVISOR", label: "Supervisor" },
  { value: "DATA_ANALYST", label: "Data Analyst" },
  { value: "ADMIN", label: "Admin" },
  { value: "SUPER_ADMIN", label: "Super Admin" },
];

export default function NewUserPage() {
  const router = useRouter();
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const [form, setForm] = useState({
    username: "",
    name: "",
    position: "",
    role: "FIELD_WORKER",
    community: "",
    password: "",
    confirmPassword: "",
  });

  function handleChange(e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) {
    setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  }

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    setError(null);

    if (form.password !== form.confirmPassword) {
      setError("Passwords do not match");
      return;
    }

    setLoading(true);
    try {
      const res = await fetch("/api/users", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          username: form.username,
          name: form.name,
          position: form.position,
          role: form.role,
          community: form.community || undefined,
          password: form.password,
        }),
      });

      if (res.status === 409) {
        setError("Username already exists");
        return;
      }
      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        setError(data.error ?? "Failed to create user");
        return;
      }

      router.push("/settings/users");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="mx-auto max-w-lg space-y-6">
      <div className="flex items-center gap-4">
        <Link href="/settings/users" className="text-ft-orange hover:underline text-sm">
          ← Back to Users
        </Link>
        <h1 className="text-2xl font-semibold text-ft-grey-dark">New User</h1>
      </div>

      {error && (
        <div className="rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
          {error}
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-4 rounded-lg border border-ft-grey-light p-6">
        <Field label="Username" name="username" value={form.username} onChange={handleChange} required />
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
        <Field label="Password" name="password" type="password" value={form.password} onChange={handleChange} required />
        <Field label="Confirm Password" name="confirmPassword" type="password" value={form.confirmPassword} onChange={handleChange} required />

        <div className="flex gap-3 pt-2">
          <button
            type="submit"
            disabled={loading}
            className="rounded-lg bg-ft-orange px-6 py-2 text-sm font-medium text-white hover:opacity-90 disabled:opacity-50"
          >
            {loading ? "Creating…" : "Create User"}
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
