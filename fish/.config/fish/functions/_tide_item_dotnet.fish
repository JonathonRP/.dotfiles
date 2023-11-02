function _tide_item_dotnet
    set -q DOTNET && set -l (dotnet --version) $DOTNET

    if test -n "$DOTNET"
        _tide_print_item dotnet $tide_dotnet_icon' ' (dotnet --version)
    end
end