"use client";

import { useState, useRef, FormEvent } from "react";
import { useSession } from "next-auth/react";

export default function ProfilePage() {
  const { data: session, update: updateSession } = useSession();
  const user = session?.user;

  const [avatarUrl, setAvatarUrl] = useState<string | null>(user?.avatarUrl ?? null);
  const [avatarMsg, setAvatarMsg] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const [profileForm, setProfileForm] = useState({
    name: user?.name ?? "",
    position: user?.position ?? "",
    community: user?.community ?? "",
  });
  const [profileMsg, setProfileMsg] = useState<string | null>(null);
  const [profileError, setProfileError] = useState<string | null>(null);
  const [profileLoading, setProfileLoading] = useState(false);

  const [pwForm, setPwForm] = useState({
    currentPassword: "",
    newPassword: "",
    confirmPassword: "",
  });
  const [pwMsg, setPwMsg] = useState<string | null>(null);
  const [pwError, setPwError] = useState<string | null>(null);
  const [pwLoading, setPwLoading] = useState(false);

  // Sync form fields when session loads
  const [synced, setSynced] = useState(false);
  if (user && !synced) {
    setProfileForm({
      name: user.name ?? "",
      position: user.position ?? "",
      community: user.community ?? "",
    });
    setAvatarUrl(user.avatarUrl ?? null);
    setSynced(true);
  }

  const initials = (user?.name ?? "?").charAt(0).toUpperCase();

  async function handleFileChange(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0];
    if (!file) return;
    setAvatarMsg(null);

    const fd = new FormData();
    fd.append("file", file);

    const res = await fetch("/api/profile/avatar", { method: "POST", body: fd });
    if (res.ok) {
      const data = await res.json();
      setAvatarUrl(data.avatarUrl);
      setAvatarMsg("Photo updated!");
      await updateSession();
    } else {
      const data = await res.json().catch(() => ({}));
      setAvatarMsg(data.error ?? "Upload failed");
    }
  }

  async function handleProfileSubmit(e: FormEvent) {
    e.preventDefault();
    setProfileMsg(null);
    setProfileError(null);
    setProfileLoading(true);

    try {
      const res = await fetch("/api/profile", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: profileForm.name,
          position: profileForm.position,
          community: profileForm.community || null,
        }),
      });

      if (res.ok) {
        setProfileMsg("Profile updated successfully!");
        await updateSession();
      } else {
        const data = await res.json().catch(() => ({}));
        setProfileError(data.error ?? "Update failed");
      }
    } finally {
      setProfileLoading(false);
    }
  }

  async function handlePwSubmit(e: FormEvent) {
    e.preventDefault();
    setPwMsg(null);
    setPwError(null);

    if (pwForm.newPassword !== pwForm.confirmPassword) {
      setPwError("New passwords do not match");
      return;
    }

    setPwLoading(true);
    try {
      const res = await fetch("/api/profile/password", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          currentPassword: pwForm.currentPassword,
          newPassword: pwForm.newPassword,
        }),
      });

      if (res.ok) {
        setPwMsg("Password updated successfully!");
        setPwForm({ currentPassword: "", newPassword: "", confirmPassword: "" });
      } else {
        const data = await res.json().catch(() => ({}));
        setPwError(data.error ?? "Failed to update password");
      }
    } finally {
      setPwLoading(false);
    }
  }

  return (
    <div className="mx-auto max-w-xl space-y-8">
      <h1 className="text-2xl font-semibold text-ft-grey-dark">My Profile</h1>

      {/* Section 1 — Avatar */}
      <section className="rounded-lg border border-ft-grey-light p-6 space-y-4">
        <h2 className="text-base font-semibold text-ft-grey-dark">Profile Photo</h2>
        <div className="flex items-center gap-4">
          {avatarUrl ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img
              src={avatarUrl}
              alt="Avatar"
              className="h-20 w-20 rounded-full object-cover border border-ft-grey-light"
            />
          ) : (
            <span className="flex h-20 w-20 items-center justify-center rounded-full bg-ft-orange text-2xl font-semibold text-white">
              {initials}
            </span>
          )}
          <div className="space-y-2">
            <button
              type="button"
              onClick={() => fileInputRef.current?.click()}
              className="rounded-lg border border-ft-orange px-4 py-2 text-sm font-medium text-ft-orange hover:bg-ft-orange hover:text-white transition-colors"
            >
              Change photo
            </button>
            <input
              ref={fileInputRef}
              type="file"
              accept="image/*"
              className="hidden"
              onChange={handleFileChange}
            />
            {avatarMsg && (
              <p className={`text-xs ${avatarMsg.includes("failed") || avatarMsg.includes("error") ? "text-red-600" : "text-green-600"}`}>
                {avatarMsg}
              </p>
            )}
          </div>
        </div>
      </section>

      {/* Section 2 — Profile Info */}
      <section className="rounded-lg border border-ft-grey-light p-6 space-y-4">
        <h2 className="text-base font-semibold text-ft-grey-dark">Profile Information</h2>

        {profileMsg && (
          <div className="rounded-lg border border-green-200 bg-green-50 px-4 py-2 text-sm text-green-700">
            {profileMsg}
          </div>
        )}
        {profileError && (
          <div className="rounded-lg border border-red-200 bg-red-50 px-4 py-2 text-sm text-red-700">
            {profileError}
          </div>
        )}

        <form onSubmit={handleProfileSubmit} className="space-y-4">
          <Field
            label="Full Name"
            value={profileForm.name}
            onChange={(v) => setProfileForm((p) => ({ ...p, name: v }))}
            required
          />
          <Field
            label="Position"
            value={profileForm.position}
            onChange={(v) => setProfileForm((p) => ({ ...p, position: v }))}
            required
          />
          <Field
            label="Community (optional)"
            value={profileForm.community}
            onChange={(v) => setProfileForm((p) => ({ ...p, community: v }))}
          />
          <button
            type="submit"
            disabled={profileLoading}
            className="rounded-lg bg-ft-orange px-6 py-2 text-sm font-medium text-white hover:opacity-90 disabled:opacity-50"
          >
            {profileLoading ? "Saving…" : "Save Profile"}
          </button>
        </form>
      </section>

      {/* Section 3 — Change Password */}
      <section className="rounded-lg border border-ft-grey-light p-6 space-y-4">
        <h2 className="text-base font-semibold text-ft-grey-dark">Change Password</h2>

        {pwMsg && (
          <div className="rounded-lg border border-green-200 bg-green-50 px-4 py-2 text-sm text-green-700">
            {pwMsg}
          </div>
        )}
        {pwError && (
          <div className="rounded-lg border border-red-200 bg-red-50 px-4 py-2 text-sm text-red-700">
            {pwError}
          </div>
        )}

        <form onSubmit={handlePwSubmit} className="space-y-4">
          <Field
            label="Current Password"
            type="password"
            value={pwForm.currentPassword}
            onChange={(v) => setPwForm((p) => ({ ...p, currentPassword: v }))}
            required
          />
          <Field
            label="New Password"
            type="password"
            value={pwForm.newPassword}
            onChange={(v) => setPwForm((p) => ({ ...p, newPassword: v }))}
            required
          />
          <Field
            label="Confirm New Password"
            type="password"
            value={pwForm.confirmPassword}
            onChange={(v) => setPwForm((p) => ({ ...p, confirmPassword: v }))}
            required
          />
          <button
            type="submit"
            disabled={pwLoading}
            className="rounded-lg bg-ft-orange px-6 py-2 text-sm font-medium text-white hover:opacity-90 disabled:opacity-50"
          >
            {pwLoading ? "Updating…" : "Update Password"}
          </button>
        </form>
      </section>
    </div>
  );
}

function Field({
  label,
  value,
  onChange,
  type = "text",
  required,
}: {
  label: string;
  value: string;
  onChange: (v: string) => void;
  type?: string;
  required?: boolean;
}) {
  return (
    <div className="space-y-1">
      <label className="block text-sm font-medium text-ft-grey-dark">{label}</label>
      <input
        type={type}
        value={value}
        onChange={(e) => onChange(e.target.value)}
        required={required}
        className="w-full rounded-lg border border-ft-grey-light px-3 py-2 text-sm focus:border-ft-orange focus:outline-none"
      />
    </div>
  );
}
