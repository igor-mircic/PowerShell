# Autocompletion #######################################################################################################

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -HistoryNoDuplicates 
Set-PSReadLineOption -BellStyle None

# Plugins
Import-Module CompletionPredictor

# Carapace Completions
Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
carapace _carapace | Out-String | Invoke-Expression

# VIM Mode #############################################################################################################

$env:EDITOR = $env:VISUAL = 'nvim'
Set-PsReadLineOption -EditMode Vi

$OnViModeChange = [scriptblock]{
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    }
    else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange

# Prompt ###############################################################################################################
# Add new line
# $GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'