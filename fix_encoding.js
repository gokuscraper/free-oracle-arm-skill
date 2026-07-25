const fs = require("fs");
const c = fs.readFileSync("README.tmp.md", "utf8");
fs.writeFileSync("README.md", c, "utf8");
console.log("done");
