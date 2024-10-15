// Self-destroying service worker (NB: *not* a coi-serviceworker.)
// See https://medium.com/@nekrtemplar/self-destroying-serviceworker-73d62921d717
self.addEventListener('install', function(e) {
    self.skipWaiting();
  });

  self.addEventListener('activate', function(e) {
    self.registration.unregister()
      .then(function() {
        return self.clients.matchAll();
      })
      .then(function(clients) {
        clients.forEach(client => client.navigate(client.url))
      });
  });