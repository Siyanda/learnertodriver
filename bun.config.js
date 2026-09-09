import path from "path"
import fs   from "fs"

const config = {
  sourcemap: "external",
  entrypoints: ["app/javascript/application.js"],
  outdir: path.join(process.cwd(), "app/assets/builds"),
};

const build = async (config) => {
  const result = await Bun.build(config);

  if (!result.success) {
    if (process.argv.includes("--watch")) {
      console.error("Build failed");
      for (const message of result.logs) {
        console.error(message);
      }
      return;
    } else {
      throw new AggregateError(result.logs, "Build failed");
    }
  }
};

(async () => {
  await build(config);

  const watchDirs = [
    path.join(process.cwd(), "app/javascript"),
    path.join(process.cwd(), "app/components")
  ]

  if (process.argv.includes("--watch")) {
    watchDirs.forEach(dir => {
      fs.watch(dir, { recursive: true }, (eventType, filename) => {
        console.log(`File changed: ${filename}. Rebuilding...`)
        build(config)
      })
    })
  }
})();
