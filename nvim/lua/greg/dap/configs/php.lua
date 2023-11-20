local dap = require("dap")

dap.adapters.php = {
  type = "executable",
  command = "php-debug-adapter",
}

dap.configurations.php = {
  {
    type = "php",
    request = "launch",
    name = "Laravel",
    port = 9643,
    pathMappings = {
      ["/var/www/html"] = "${workspaceFolder}",
    },
  },
  {
    type = "php",
    request = "launch",
    name = "Symfony",
    port = 9643,
    pathMappings = {
      ["/app"] = "${workspaceFolder}",
    },
  },
}
