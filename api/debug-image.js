export default async function handler(req, res) {
  try {
    const origin = `https://${req.headers.host}`;
    const response = await fetch(`${origin}/mapi-home-desktop.png`);
    if (!response.ok) {
      res.status(response.status).send('asset fetch failed');
      return;
    }
    const bytes = Buffer.from(await response.arrayBuffer());
    res.setHeader('Content-Type', 'text/plain; charset=utf-8');
    res.status(200).send(bytes.toString('base64'));
  } catch (error) {
    res.status(500).send(String(error?.message || error));
  }
}
