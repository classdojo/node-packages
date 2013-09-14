Packages helps break your node.js application down into smaller, manageable pieces. 

### Example

```
- package.json - application package
- lib/ - javascript source files
  - index.js - main entry point
    - packages/ - application components
      - config/ - application config component
      - http.server/ - http server component
        - index.js   - package entry point
      - http.routes/ - http routes
        - index.js   
```

In `lib/index.js`, you'll need something like:

```javascript
var packages = require("packages");

packages.
require(__dirname + "/packages").
load();
```

In `http.server/index.js`, you might have something like:

```javascript
exports.require = ["express", "config"];
exports.load = function (express, config) {
  var app = express()
  app.listen(config.get("port"));
  return app;
};
```

In `http.routes/index.js`, you might have something like:

```javascript
exports.require = ["http.server"];
exports.load = function (app) {
  app.get("/hello", function (req, res) {
    res.send("Hello World!");
  });
};
```

### API
