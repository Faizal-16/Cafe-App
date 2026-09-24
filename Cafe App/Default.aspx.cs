using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

namespace Cafe_App
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Category { get; set; }
        public string Desc { get; set; }
        public string Emoji { get; set; }
        public decimal Price { get; set; }
    }

    public class CartLine
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Qty { get; set; }
        public decimal Total { get; set; }
    }

    public partial class Default : System.Web.UI.Page
    {
        // Change names/prices here to edit the menu.
        static readonly List<Product> Menu = new List<Product>
        {
            new Product { Id = 1, Emoji = "\u2615",  Category = "Coffee", Name = "Espresso",        Desc = "Double shot, rich and bold",          Price = 2.50m },
            new Product { Id = 2, Emoji = "\u2615",  Category = "Coffee", Name = "Cappuccino",      Desc = "Espresso, steamed milk, thick foam",  Price = 3.50m },
            new Product { Id = 3, Emoji = "\U0001F95B",  Category = "Coffee", Name = "Vanilla Latte",   Desc = "Smooth and lightly sweet",            Price = 3.75m },
            new Product { Id = 4, Emoji = "\U0001F9CA",  Category = "Coffee", Name = "Cold Brew",       Desc = "Steeped 18 hours, served over ice",   Price = 4.00m },
            new Product { Id = 5, Emoji = "\U0001F375",  Category = "Tea",    Name = "Masala Chai",     Desc = "Ginger, cardamom and black tea",     Price = 2.75m },
            new Product { Id = 6, Emoji = "\U0001F33F",  Category = "Tea",    Name = "Green Tea",       Desc = "Light, grassy and clean",             Price = 2.50m },
            new Product { Id = 7, Emoji = "\U0001F343",  Category = "Tea",    Name = "Matcha Latte",    Desc = "Stone-ground matcha with oat milk",   Price = 4.25m },
            new Product { Id = 8, Emoji = "\U0001F950",  Category = "Bakery", Name = "Butter Croissant", Desc = "Baked fresh every morning",         Price = 3.00m },
            new Product { Id = 9, Emoji = "\U0001F9C1",  Category = "Bakery", Name = "Blueberry Muffin", Desc = "Soft, with a crisp sugar top",      Price = 2.90m },
            new Product { Id = 10, Emoji = "\U0001F370", Category = "Bakery", Name = "Chocolate Cake",  Desc = "Dark chocolate, one generous slice",  Price = 4.50m }
        };

        static readonly string[] Categories = { "All", "Coffee", "Tea", "Bakery" };

        protected string CurrentFilter
        {
            get { return (string)ViewState["filter"] ?? "All"; }
            set { ViewState["filter"] = value; }
        }

        // Cart lives in the session: product id -> quantity
        Dictionary<int, int> Cart
        {
            get
            {
                var cart = Session["cart"] as Dictionary<int, int>;
                if (cart == null) { cart = new Dictionary<int, int>(); Session["cart"] = cart; }
                return cart;
            }
        }

        // Runs after button events, so the page always shows the latest cart.
        protected void Page_PreRender(object sender, EventArgs e)
        {
            rptCats.DataSource = Categories;
            rptCats.DataBind();

            rptMenu.DataSource = CurrentFilter == "All" ? Menu : Menu.Where(m => m.Category == CurrentFilter).ToList();
            rptMenu.DataBind();

            var lines = Cart.OrderBy(kv => kv.Key).Select(kv =>
            {
                var p = Menu.First(x => x.Id == kv.Key);
                return new CartLine { Id = p.Id, Name = p.Name, Qty = kv.Value, Total = p.Price * kv.Value };
            }).ToList();

            rptCart.DataSource = lines;
            rptCart.DataBind();

            pnlEmpty.Visible = lines.Count == 0;
            pnlCheckout.Visible = lines.Count > 0;
            lblTotal.Text = lines.Sum(l => l.Total).ToString("C");
        }

        protected void rptCats_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            CurrentFilter = (string)e.CommandArgument;
        }

        protected void rptMenu_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Change(Convert.ToInt32(e.CommandArgument), 1);
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Change(Convert.ToInt32(e.CommandArgument), e.CommandName == "plus" ? 1 : -1);
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            if (Cart.Count == 0) return;

            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                Show("Enter a name so we know who to call.", false);
                return;
            }

            int orderNo = new Random().Next(100, 1000);
            Show("Thanks, " + Server.HtmlEncode(txtName.Text.Trim()) + "! Order #" + orderNo + " is being prepared.", true);
            Cart.Clear();
            txtName.Text = "";
        }

        void Change(int id, int delta)
        {
            int qty;
            Cart.TryGetValue(id, out qty);
            qty += delta;
            if (qty <= 0) Cart.Remove(id); else Cart[id] = qty;
        }

        void Show(string text, bool ok)
        {
            lblMsg.Text = text;
            lblMsg.CssClass = ok ? "msg ok" : "msg err";
        }
    }
}
