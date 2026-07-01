-- 外部でファイルが変更されたときの再読み込み挙動
--   - バッファ未編集: 自動でリロード（通知あり）
--   - バッファ編集中: 通知して、破棄してリロードするか確認する（reload / keep / diff）
return {
	"ccntrq/autoreload.nvim",
	event = "VeryLazy",
	opts = {
		autoread = true,
		-- フォーカス/移動に加え、編集中・アイドル中も外部変更を検知する
		events = { "BufEnter", "FocusGained", "CursorHold", "CursorHoldI" },
		timer = {
			enabled = true,
			interval_ms = 1000,
			start_delay_ms = 0,
		},
		conflict = {
			strategy = "prompt", -- 編集中の衝突は対話ダイアログで確認する
			actions = { "reload", "keep", "diff" },
			default = "keep", -- Esc 時は自分の変更を保持する
		},
		notify = {
			on_conflict = true,
			on_reload = true, -- 未編集リロード時にも通知する
		},
	},
}
