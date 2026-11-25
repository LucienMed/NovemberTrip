# O家畢業遊網站：設定步驟

一個純靜態網站（`index.html` + `config.js`），資料（投票、清單、留言、快速新增、相片）儲存喺免費嘅 Supabase。唔使 Claude 帳戶，香港都打得開。

## 1. 開 Supabase 數據庫（大約 5 分鐘）

1. 去 https://supabase.com 開帳戶，撳 **New project**。Region 揀 **Sydney** 或者 **Singapore**。
2. 開好之後，左邊揀 **SQL Editor** → New query，將 `supabase.sql` 全部貼落去，撳 **Run**。
   - 佢會開 `trip` 表（已經放咗 Leo 投咗嘅票）、設定權限，同埋開 `photos` 相簿 bucket。
3. 去 **Project Settings → API**（或者 Data API），抄低：
   - Project URL（例如 `https://abcd1234.supabase.co`）
   - `anon` / publishable key（**唔好**用 `service_role` / secret key）
4. 打開 `config.js`，將兩樣嘢填入 `url` 同 `key`。

## 2. 放上網（揀一個）

- **Netlify Drop**：去 https://app.netlify.com/drop ，將成個資料夾拖入去，就有一條 link。
- **GitHub Pages**：開一個 repo，push 三個檔案，Settings → Pages → Deploy from branch。
- **Cloudflare Pages**：Upload assets，揀呢個資料夾。

## 3. 分享

將條 link send 去家庭 WhatsApp group。每個人第一次打開，撳右上角揀自己係邊個就得。

## 要留意

- **有 link 嘅人都可以改同上載相**，所以唔好公開 post 條 link。
- 免費 Supabase project 如果大約一星期冇人用，可能會暫停；出發前登入 Supabase 確認 project 係 active。
- 資料每 8 秒自動更新一次；兩個人同時改都唔會蓋咗對方。
- 未填 `config.js` 嘅話，網站會用「示範模式」，資料只會留喺嗰部機。
- 想改行程內容（活動、時間、連結），喺 `index.html` 入面搵 `const DAYS=` 改就得。
- 想清空重新嚟過：Supabase → Table Editor → `trip`，改 `state` 欄。
