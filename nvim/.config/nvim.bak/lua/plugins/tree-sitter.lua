return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Parsers base que ya tenías instalados
        "bash",
        "c",
        "diff",
        "dockerfile",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "prisma",
        "python",
        "query",
        "regex",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",

        -- Desarrollo Web Frontend (HTML/CSS/JS)
        "css",
        "scss",
        "graphql", -- Para consultas GraphQL
        "http", -- Para archivos HTTP/solicitudes API

        -- Desarrollo Python
        "python", -- Ya incluido, pero lo dejamos explícito
        "rst", -- Para documentación Python (reStructuredText)
        "requirements", -- Para requirements.txt

        -- Backend y APIs
        "nginx", -- Configuración de servidores web
        "hurl", -- Para archivos .hurl (HTTP requests)

        -- Formatos de datos
        "csv", -- Para archivos CSV
        "yuck", -- Para configuraciones (como AwesomeWM)

        -- Herramientas de desarrollo
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",

        -- Otros útiles
        "make",
        "ninja",
        "terraform", -- Para infraestructura como código
        "dockerfile", -- Ya incluido, pero importante para Docker
      },
    },
  },
}
