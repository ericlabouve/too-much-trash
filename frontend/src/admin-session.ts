/** Clear this browser's session, not every copy of the stateless admin cookie. */
export async function logoutAdmin(
  request: typeof fetch,
  navigate: (path: string) => void,
): Promise<void> {
  const response = await request("/api/v1/admin/session", {
    method: "DELETE", credentials: "same-origin", cache: "no-store",
    redirect: "error", headers: { "X-TMT-Admin": "1" },
  });
  if (response.status !== 204) {
    throw new Error("Could not confirm logout. Please retry.");
  }
  navigate("/unlock");
}
