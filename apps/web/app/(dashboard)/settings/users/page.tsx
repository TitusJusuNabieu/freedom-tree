import { redirect } from "next/navigation";
import { getServerSession } from "next-auth";
import Link from "next/link";
import { Prisma } from "@prisma/client";
import { authOptions } from "@/lib/auth/nextAuthOptions";
import { prisma } from "@/lib/prisma";
import { DeactivateButton } from "./_components/DeactivateButton";

const ROLE_COLORS: Record<string, string> = {
  SUPER_ADMIN: "bg-purple-100 text-purple-800",
  ADMIN: "bg-blue-100 text-blue-800",
  SUPERVISOR: "bg-indigo-100 text-indigo-800",
  DATA_ANALYST: "bg-teal-100 text-teal-800",
  FIELD_WORKER: "bg-green-100 text-green-800",
};

const ROLE_LABELS: Record<string, string> = {
  SUPER_ADMIN: "Super Admin",
  ADMIN: "Admin",
  SUPERVISOR: "Supervisor",
  DATA_ANALYST: "Data Analyst",
  FIELD_WORKER: "Field Worker",
};

export default async function UsersPage({
  searchParams,
}: {
  searchParams: { search?: string; role?: string; active?: string; page?: string };
}) {
  const session = await getServerSession(authOptions);
  if (session?.user?.role !== "SUPER_ADMIN") redirect("/");

  const page = Math.max(1, parseInt(searchParams.page ?? "1", 10) || 1);
  const pageSize = 20;

  const where: Prisma.UserWhereInput = {};
  if (searchParams.role) where.role = searchParams.role as never;
  if (searchParams.active !== undefined && searchParams.active !== "") {
    where.active = searchParams.active === "true";
  }
  if (searchParams.search) {
    where.OR = [
      { name: { contains: searchParams.search, mode: "insensitive" } },
      { username: { contains: searchParams.search, mode: "insensitive" } },
    ];
  }

  const [users, total] = await Promise.all([
    prisma.user.findMany({
      where,
      select: {
        id: true,
        username: true,
        name: true,
        position: true,
        role: true,
        community: true,
        avatarUrl: true,
        active: true,
      },
      orderBy: { createdAt: "desc" },
      skip: (page - 1) * pageSize,
      take: pageSize,
    }),
    prisma.user.count({ where }),
  ]);

  const totalPages = Math.ceil(total / pageSize);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-semibold text-ft-grey-dark">User Management</h1>
        <Link
          href="/settings/users/new"
          className="rounded-lg bg-ft-orange px-4 py-2 text-sm font-medium text-white hover:opacity-90"
        >
          + New User
        </Link>
      </div>

      {/* Filter bar */}
      <form className="flex flex-wrap gap-3" method="GET">
        <input
          name="search"
          defaultValue={searchParams.search ?? ""}
          placeholder="Search name or username…"
          className="rounded-lg border border-ft-grey-light px-3 py-2 text-sm focus:border-ft-orange focus:outline-none"
        />
        <select
          name="role"
          defaultValue={searchParams.role ?? ""}
          className="rounded-lg border border-ft-grey-light px-3 py-2 text-sm focus:border-ft-orange focus:outline-none"
        >
          <option value="">All roles</option>
          {Object.entries(ROLE_LABELS).map(([val, label]) => (
            <option key={val} value={val}>{label}</option>
          ))}
        </select>
        <select
          name="active"
          defaultValue={searchParams.active ?? ""}
          className="rounded-lg border border-ft-grey-light px-3 py-2 text-sm focus:border-ft-orange focus:outline-none"
        >
          <option value="">All statuses</option>
          <option value="true">Active</option>
          <option value="false">Inactive</option>
        </select>
        <button
          type="submit"
          className="rounded-lg bg-ft-grey-light px-4 py-2 text-sm font-medium hover:bg-ft-grey-dark hover:text-white"
        >
          Filter
        </button>
      </form>

      {/* Table */}
      <div className="overflow-x-auto rounded-lg border border-ft-grey-light">
        <table className="w-full text-sm">
          <thead className="border-b border-ft-grey-light bg-gray-50">
            <tr>
              <th className="px-4 py-3 text-left font-medium text-ft-grey-dark">Avatar</th>
              <th className="px-4 py-3 text-left font-medium text-ft-grey-dark">Name</th>
              <th className="px-4 py-3 text-left font-medium text-ft-grey-dark">Username</th>
              <th className="px-4 py-3 text-left font-medium text-ft-grey-dark">Role</th>
              <th className="px-4 py-3 text-left font-medium text-ft-grey-dark">Community</th>
              <th className="px-4 py-3 text-left font-medium text-ft-grey-dark">Status</th>
              <th className="px-4 py-3 text-left font-medium text-ft-grey-dark">Actions</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-ft-grey-light">
            {users.map((user) => (
              <tr key={user.id} className="hover:bg-gray-50">
                <td className="px-4 py-3">
                  {user.avatarUrl ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img
                      src={user.avatarUrl}
                      alt=""
                      className="h-8 w-8 rounded-full object-cover"
                    />
                  ) : (
                    <span className="flex h-8 w-8 items-center justify-center rounded-full bg-ft-orange text-xs font-semibold text-white">
                      {user.name.charAt(0).toUpperCase()}
                    </span>
                  )}
                </td>
                <td className="px-4 py-3">
                  <div className="font-medium text-ft-grey-dark">{user.name}</div>
                  <div className="text-xs text-ft-grey-light">{user.position}</div>
                </td>
                <td className="px-4 py-3 text-ft-grey-dark">{user.username}</td>
                <td className="px-4 py-3">
                  <span
                    className={`inline-flex rounded-full px-2 py-0.5 text-xs font-semibold ${ROLE_COLORS[user.role] ?? "bg-gray-100 text-gray-800"}`}
                  >
                    {ROLE_LABELS[user.role] ?? user.role}
                  </span>
                </td>
                <td className="px-4 py-3 text-ft-grey-dark">{user.community ?? "—"}</td>
                <td className="px-4 py-3">
                  <span
                    className={`inline-flex rounded-full px-2 py-0.5 text-xs font-semibold ${user.active ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800"}`}
                  >
                    {user.active ? "Active" : "Inactive"}
                  </span>
                </td>
                <td className="px-4 py-3">
                  <div className="flex items-center gap-2">
                    <Link
                      href={`/settings/users/${user.id}/edit`}
                      className="text-ft-orange hover:underline"
                    >
                      Edit
                    </Link>
                    <DeactivateButton userId={user.id} active={user.active} />
                  </div>
                </td>
              </tr>
            ))}
            {users.length === 0 && (
              <tr>
                <td colSpan={7} className="px-4 py-8 text-center text-ft-grey-light">
                  No users found.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between text-sm">
          <span className="text-ft-grey-light">
            {total} users · page {page} of {totalPages}
          </span>
          <div className="flex gap-2">
            {page > 1 && (
              <Link
                href={`?${new URLSearchParams({ ...searchParams, page: String(page - 1) }).toString()}`}
                className="rounded border border-ft-grey-light px-3 py-1 hover:border-ft-orange hover:text-ft-orange"
              >
                Previous
              </Link>
            )}
            {page < totalPages && (
              <Link
                href={`?${new URLSearchParams({ ...searchParams, page: String(page + 1) }).toString()}`}
                className="rounded border border-ft-grey-light px-3 py-1 hover:border-ft-orange hover:text-ft-orange"
              >
                Next
              </Link>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
