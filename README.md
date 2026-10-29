# MStudio 手作鈎織

公開網址（Google 可收錄）：[https://mstudiocrochet.github.io/](https://mstudiocrochet.github.io/)

靜態商店頁：首頁、商品列表、商品詳情、購物籃，購入時把訂單文字複製並開啟 Instagram 訊息。

## 必須用 http 開啟

**不要雙擊 HTML。** 請用本機網頁伺服器，否則動態內容會載入失敗。

原因：

- 首頁 `fetch("pic/page/home.html")`
- 商品列表 `fetch("pic/products/catalog.json")` 再讀各資料夾 `goods.json`
- 商品詳情 `fetch("pic/products/{id}/goods.json")` 與 `describe.md`

用 `file://` 開啟時，瀏覽器通常會擋這些請求。

### 預覽

在專案根目錄執行：

```bash
python -m http.server
```

瀏覽器開啟終端機顯示的位址（預設 [http://127.0.0.1:8000/](http://127.0.0.1:8000/)）。列表依賴 Python `http.server` 的目錄頁，請用這個方式預覽。

改標題列、Tab、購物籃列請直接編輯根目錄的 `index.html`、`products.html`、`product.html`。下列情況只要重新整理瀏覽器即可：

- 改 `pic/page/home.html`
- 在 `pic/products/` 新增或刪除商品資料夾
- 改某商品的 `goods.json`、圖片、`describe.md`

## 頁面與載入

| 頁面 | 載入什麼 |
| --- | --- |
| `index.html` | `pic/page/home.html`（HTML，可改顏色、插圖） |
| `products.html` | `pic/products/` 子資料夾，再讀各 `goods.json` 與 `exhibit.png` |
| `product.html?id=資料夾名` | 該資料夾的 `goods.json`、`exhibit.png`、`describe.md`、存在的 `content1.png`～`content5.png` |

首頁圖片路徑以網站根目錄起算，例如 `pic/page/buy.png`。

## 商品資料夾

一個商品一個資料夾，例如 `pic/products/flower/`：

| 檔案 | 必要 | 說明 |
| --- | --- | --- |
| `exhibit.png` | 是 | 列表與詳情大圖 |
| `goods.json` | 是 | `name`（字串）、`price`（整數）、`stock`（整數） |
| `content1.png` … `content5.png` | 否 | 詳情縮圖，沒有檔案就不顯示 |
| `describe.md` | 否 | 詳情簡介 |

`goods.json` 範例：

```json
{
  "name": "櫻花粉紙線",
  "price": 180,
  "stock": 8
}
```

資料夾名稱就是商品 id（網址 `product.html?id=flower`）。缺 `goods.json` 或沒有可用名稱、價格的資料夾，列表會跳過。

## 購物籃與購入

購物籃存在瀏覽器 `localStorage`。列表可選數量後按「🛒」；詳情頁的「🛒」每次加 1 件。

「清單」顯示品項（幾種商品，不是總件數），可刪單一品項。「購入」複製：

```text
櫻花粉紙線 x 2
海藍紙線 x 1
```

並開新分頁 `https://ig.me/m/m_and_studio`。清單是空的則不動作。數量大於庫存（含庫存 0）會先確認：「您選擇的部分商品目前庫存數量不足，下單後商品製作會需要些時間」。Instagram 不會自動送出訊息；未登入會先登入，再自行貼上並送出。

## 依賴

- 瀏覽器
- Python 3（`python -m http.server` 預覽）
