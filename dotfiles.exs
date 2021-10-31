defmodule Dotfiles do
  def main(args \\ []) do
    {opts, remaining} =
      OptionParser.parse_head!(args,
        strict: [help: :boolean, verbose: :boolean],
        aliases: [h: :help, v: :verbose]
      )

    if opts[:help], do: help()

    case remaining do
      ["install" | rest] -> install(rest, opts)
      _ -> help()
    end
  end

  def install(args \\ [], prev_opts \\ []) do
    {opts, remaining} =
      OptionParser.parse_head!(args,
        strict: [help: :boolean, verbose: :boolean],
        aliases: [h: :help, v: :verbose]
      )

    neovim_init()
    npm_deps()
    alacritty_yml()

    IO.puts("some install stuff")
  end

  def neovim_init(opts \\ []) do
    dir = Path.expand("$HOME/.config/nvim")
    file = Path.join(dir, "init.vim")

    if not File.exists?(dir) do
      File.mkdir_p(dir)
    end

    ok_write? =
      cond do
        not File.exists?(file) -> true
        opts[:force] -> true
        IO.gets("init.vim exists, overwrite? [y/N]> ") =~ ~r/^y/i -> true
        true -> false
      end

    if ok_write? do
      File.write!(file, "source $DOTFILES/init.lua\n")
    else
      IO.puts(:stderr, "init.vim already exists")
      System.stop(1)
    end

    # {_, 0} = System.shell("npm install --global neovim")
    # {_, 0} = System.shell("pip3 install --user --upgrade pynvim")
    {_, 0} = System.shell("pip3 install --user --upgrade neovim-remote")
  end

  def npm_deps() do
    packages = [
      "vim-language-server",
      "bash-language-server",
      "prettier",
      "typescript",
      "typescript-language-server",
      "vscode-langservers-extracted"
    ]

    cmd = "npm install --globabl #{Enum.join("packages")}"

    IO.puts(cmd)
    {_, 0} = System.shell(cmd)
  end

  def alacritty_yml() do
    full_dotfiles_dir = System.fetch_env!("DOTFILES")
    home = System.fetch_env!("HOME")
    relative_dotfiles = Path.relative_to(full_dotfiles_dir, home)

    # all for the pretty print
    base_yml = Path.join(["~", relative_dotfiles, "alacritty.yml"])

    file = ~s"""
    import:
      - #{base_yml}
    """

    dir = Path.expand("~/.config/alacritty")

    File.mkdir_p!(dir)

    file_path = Path.join(dir, "alacritty.yml")

    File.write!(file_path, file)
  end

  # cp .tool-versions "$HOME"
  def copy_tool_versions() do
    File.cp!("this_dir/.tool-versions", "$HOME/.tool-versions")
  end

  def help() do
    ~S"""
    This is some help

    on multiple "lines"
    """
    |> then(&IO.puts(:stderr, &1))

    System.stop(1)
  end
end

System.argv()
|> Dotfiles.main()
