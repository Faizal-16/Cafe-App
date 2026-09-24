<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Cafe_App.Default" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Bean &amp; Brew Cafe</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;600&family=Fraunces:wght@600;700&display=swap" rel="stylesheet" />
<style>
:root{--ink:#fff7ea;--dim:rgba(255,247,234,.68);--glass:rgba(255,255,255,.09);--edge:rgba(255,255,255,.22);--amber:#ffb347}
*{box-sizing:border-box}
body{margin:0;min-height:100vh;color:var(--ink);font-family:"DM Sans","Segoe UI",sans-serif;line-height:1.5;background:#140f0d;overflow-x:hidden}
.bg{position:fixed;top:0;left:0;right:0;bottom:0;z-index:-1;overflow:hidden}
.bg i{position:absolute;border-radius:50%;filter:blur(90px);opacity:.75}
.bg i:nth-child(1){width:480px;height:480px;background:#e8871e;top:-120px;left:-100px;animation:drift 18s ease-in-out infinite alternate}
.bg i:nth-child(2){width:420px;height:420px;background:#c2416b;top:30%;right:-120px;animation:drift 22s ease-in-out infinite alternate-reverse}
.bg i:nth-child(3){width:520px;height:520px;background:#1f8a80;bottom:-180px;left:25%;animation:drift 26s ease-in-out infinite alternate}
@keyframes drift{to{transform:translate(60px,40px)}}
@media(prefers-reduced-motion:reduce){.bg i{animation:none}}

.glass{background:var(--glass);border:1px solid var(--edge);-webkit-backdrop-filter:blur(18px) saturate(150%);backdrop-filter:blur(18px) saturate(150%);box-shadow:0 8px 32px rgba(0,0,0,.35),inset 0 1px 0 rgba(255,255,255,.25)}
.hero,.wrap{width:min(1120px,calc(100% - 32px));margin-left:auto;margin-right:auto}
.hero{margin-top:24px;margin-bottom:20px;padding:38px;border-radius:28px}
.hero h1{font-family:Fraunces,Georgia,serif;font-size:clamp(2.4rem,6vw,4rem);line-height:1.05;margin:0 0 8px;letter-spacing:-.02em}
.hero p{margin:0 0 16px;color:var(--dim);max-width:52ch}
.pill{display:inline-block;padding:5px 14px;margin:0 6px 6px 0;border-radius:99px;background:rgba(255,255,255,.12);border:1px solid var(--edge);font-size:.9rem}

.wrap{display:grid;grid-template-columns:1fr 350px;gap:24px;align-items:start;margin-bottom:48px}
.chips{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:16px}
.chip{padding:7px 18px;border-radius:99px;color:var(--ink);text-decoration:none;background:var(--glass);border:1px solid var(--edge);-webkit-backdrop-filter:blur(12px);backdrop-filter:blur(12px)}
.chip:hover{border-color:var(--amber)}
.chip.active{background:linear-gradient(135deg,#ffc36b,#ff8a3d);border-color:transparent;color:#2a1400;font-weight:600}

.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:16px}
.card{border-radius:22px;padding:18px;display:flex;flex-direction:column;transition:transform .2s,border-color .2s}
.card:hover{transform:translateY(-3px);border-color:var(--amber)}
.ico{width:56px;height:56px;border-radius:16px;display:grid;place-items:center;font-size:1.9rem;background:rgba(255,255,255,.12);border:1px solid var(--edge);margin-bottom:10px}
.card h3{font-family:Fraunces,Georgia,serif;margin:0 0 2px;font-size:1.2rem}
.card p{margin:0;color:var(--dim);font-size:.9rem;flex:1}
.foot{display:flex;align-items:center;justify-content:space-between;margin-top:14px}
.price{font-weight:600;color:var(--amber);font-size:1.05rem}

.btn{background:linear-gradient(135deg,#ffc36b,#ff8a3d);color:#2a1400;border:0;border-radius:12px;padding:8px 18px;font:inherit;font-weight:600;cursor:pointer;box-shadow:0 4px 14px rgba(255,138,61,.35);transition:filter .15s}
.btn:hover{filter:brightness(1.1)}
.btn:focus-visible,.chip:focus-visible,.input:focus-visible{outline:2px solid #fff;outline-offset:2px}

.cart{position:sticky;top:20px;border-radius:26px;padding:22px}
.cart h2{font-family:Fraunces,Georgia,serif;margin:0 0 6px;font-size:1.6rem}
.muted{color:var(--dim);padding:8px 0}
.line{display:flex;justify-content:space-between;align-items:center;gap:10px;padding:10px 0;border-bottom:1px solid rgba(255,255,255,.14)}
.line small{color:var(--dim)}
.qty{display:flex;align-items:center;gap:8px}
.btn.q{background:rgba(255,255,255,.14);color:var(--ink);box-shadow:none;padding:2px 11px;border-radius:9px}
.total{display:flex;justify-content:space-between;font-size:1.3rem;padding:14px 0 10px}
.input{width:100%;padding:11px 14px;border-radius:12px;border:1px solid var(--edge);background:rgba(255,255,255,.1);color:var(--ink);font:inherit}
.input::placeholder{color:var(--dim)}
.btn.big{width:100%;margin-top:12px;padding:12px;font-size:1rem}
.msg{display:block;margin-top:12px;padding:10px 12px;border-radius:12px;font-weight:600}
.msg.ok{background:rgba(80,200,140,.2);color:#b6f5d3}
.msg.err{background:rgba(255,90,90,.2);color:#ffc2c2}
@media(max-width:860px){.wrap{grid-template-columns:1fr}.cart{position:static}.hero{padding:24px}}
</style>
</head>
<body>
<div class="bg"><i></i><i></i><i></i></div>
<form id="form1" runat="server">
  <header class="hero glass">
    <h1>Bean &amp; Brew</h1>
    <p>Small-batch coffee, chai and fresh bakes. Order from your table and we'll bring it over.</p>
    <span class="pill">Open 7am to 9pm</span><span class="pill">Free Wi-Fi</span>
  </header>

  <div class="wrap">
    <main>
      <div class="chips">
        <asp:Repeater ID="rptCats" runat="server" OnItemCommand="rptCats_ItemCommand">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="filter" CommandArgument='<%# Container.DataItem %>'
              Text='<%# Container.DataItem %>'
              CssClass='<%# (string)Container.DataItem == CurrentFilter ? "chip active" : "chip" %>' />
          </ItemTemplate>
        </asp:Repeater>
      </div>

      <div class="grid">
        <asp:Repeater ID="rptMenu" runat="server" OnItemCommand="rptMenu_ItemCommand">
          <ItemTemplate>
            <div class="card glass">
              <div class="ico"><%# Eval("Emoji") %></div>
              <h3><%# Eval("Name") %></h3>
              <p><%# Eval("Desc") %></p>
              <div class="foot">
                <span class="price"><%# Eval("Price", "{0:C}") %></span>
                <asp:Button runat="server" Text="Add" CommandName="add" CommandArgument='<%# Eval("Id") %>' CssClass="btn" />
              </div>
            </div>
          </ItemTemplate>
        </asp:Repeater>
      </div>
    </main>

    <aside class="cart glass">
      <h2>Your order</h2>

      <asp:Panel ID="pnlEmpty" runat="server" CssClass="muted">
        Nothing here yet. Add a drink from the menu.
      </asp:Panel>

      <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
        <ItemTemplate>
          <div class="line">
            <div><b><%# Eval("Name") %></b><br /><small><%# Eval("Total", "{0:C}") %></small></div>
            <div class="qty">
              <asp:Button runat="server" Text="-" CommandName="minus" CommandArgument='<%# Eval("Id") %>' CssClass="btn q" />
              <span><%# Eval("Qty") %></span>
              <asp:Button runat="server" Text="+" CommandName="plus" CommandArgument='<%# Eval("Id") %>' CssClass="btn q" />
            </div>
          </div>
        </ItemTemplate>
      </asp:Repeater>

      <asp:Panel ID="pnlCheckout" runat="server">
        <div class="total"><span>Total</span><b><asp:Label ID="lblTotal" runat="server" /></b></div>
        <asp:TextBox ID="txtName" runat="server" CssClass="input" MaxLength="40" placeholder="Name for the order" />
        <asp:Button ID="btnOrder" runat="server" Text="Place order" CssClass="btn big" OnClick="btnOrder_Click" />
      </asp:Panel>

      <asp:Label ID="lblMsg" runat="server" EnableViewState="false" />
    </aside>
  </div>
</form>
</body>
</html>
