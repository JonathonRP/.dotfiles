function _tide_item_dotnet
    if type -q dotnet
        _tide_print_item dotnet $tide_dotnet_icon' ' (dotnet --version)
    end
end