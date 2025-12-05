const http = require('http');
const port = 8080;

const requestHandler = (req, res) => {
  if (req.url === '/health') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('ok');
    console.log('health endpoint hit');
    return;
  }

  if (req.url === '/') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello from private EC2 behind ALB!');
    console.log('root endpoint hit');
    return;
  }

  res.writeHead(404, { 'Content-Type': 'text/plain' });
  res.end('Not Found');
};

const server = http.createServer(requestHandler);

server.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
