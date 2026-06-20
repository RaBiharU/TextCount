#Requires AutoHotkey v2.0

; Ctrl(^) + Win(#) + C をトリガーに設定
^#c:: {
    ; クリップボードの履歴を一時的に空にして誤動作を防止
    A_Clipboard := ""
    
    ; 裏で自動的に「Ctrl+C」を送信してテキストをコピー
    Send("^c")
    
    ; コピーが完了するまで最大1秒待機
    if !ClipWait(1)
        return
    
    text := A_Clipboard
    
    ; Windows特有の改行（\r\n）を（\n）に統一し、改行が2文字分カウントされるのを防止
    text := StrReplace(text, "`r`n", "`n")
    
    ; 1. 空白・改行込みの文字数（そのままカウント）
    totalCount := StrLen(text)
    
    ; 2. 改行を除く文字数（改行だけを削除してカウント）
    textNoNewline := StrReplace(text, "`n", "")
    noNewlineCount := StrLen(textNoNewline)
    
    ; 3. 空白・改行を除く文字数（スペースやタブもすべて削除してカウント）
    textNoSpace := RegExReplace(text, "\s", "")
    noSpaceCount := StrLen(textNoSpace)
    
    ; ポップアップ表示
    ToolTip(
        "【文字数】`n"
        "文字数: " totalCount " 文字`n"
        "改行除く : " noNewlineCount " 文字`n"
        ;"空白・改行除く: " noSpaceCount " 文字"
    )
    
    ; 表示時間3秒（-3000）
    SetTimer(() => ToolTip(), -3000)
}