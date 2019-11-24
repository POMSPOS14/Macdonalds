package ru.rosbank.javaschool.web.servlet;

import ru.rosbank.javaschool.util.SQLTemplate;
import ru.rosbank.javaschool.web.constant.Constants;
import ru.rosbank.javaschool.web.model.OrderPositionModel;
import ru.rosbank.javaschool.web.model.ProductModel;
import ru.rosbank.javaschool.web.repository.*;
import ru.rosbank.javaschool.web.service.BurgerAdminService;
import ru.rosbank.javaschool.web.service.BurgerUserService;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;


public class FrontServlet extends HttpServlet {
    private BurgerUserService burgerUserService;
    private BurgerAdminService burgerAdminService;


    @Override
    public void init() throws ServletException {
        log("Init");

        try {

            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("java:/comp/env/jdbc/db");
            SQLTemplate sqlTemplate = new SQLTemplate();
            ProductRepository productRepository = new ProductRepositoryJdbcImpl(dataSource, sqlTemplate);
            OrderRepository orderRepository = new OrderRepositoryJdbcImpl(dataSource, sqlTemplate);
            OrderPositionRepository orderPositionRepository = new OrderPositionRepositoryJdbcImpl(dataSource, sqlTemplate);
            burgerUserService = new BurgerUserService(productRepository, orderRepository, orderPositionRepository);
            burgerAdminService = new BurgerAdminService(productRepository, orderRepository, orderPositionRepository);

            insertInitialData(productRepository);
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    private void insertInitialData(ProductRepository productRepository) {
        productRepository.save(new ProductModel(0, "Cheeseburger", 150, 1, "https://i2.stat01.com/1/7145/71447582/795f32/chizburger-fresh.png", Constants.BURGERS,Constants.BURGER1Description));
        productRepository.save(new ProductModel(0, "Chikenburger", 200, 1, "https://adler-dostavka24.ru/wp-content/uploads/2019/10/jhyg35hdhfixw3535sf35.png", Constants.BURGERS,Constants.BURGER2Description));
        productRepository.save(new ProductModel(0, "Cola", 120, 1, "https://media.entertainmentearth.com/assets/images/338aa312051b4999943929da1c81e5dclg.jpg", Constants.DRINKS,Constants.DRINKS1Description));
        productRepository.save(new ProductModel(0, "Milkshake", 140, 1, "https://sweetstore24.ru/wp-content/uploads/2016/10/7N8sRG8vhzoxexeS4M9Mhg.png", Constants.DRINKS,Constants.DRINKS2Description));
        productRepository.save(new ProductModel(0, "Ice cream ", 60, 1, "http://i4.stat01.com/1/7234/72333659/afacdb/icecreamchocolate-big-png.png", Constants.DESSERTS,Constants.DESSERTS1Description));
        productRepository.save(new ProductModel(0, "Pie", 70, 1, "http://i.siteapi.org/YPKKH5m9nAGOuUa7cSCDEVdqkgM=/fit-in/1024x768/center/top/33cb0aaeddc243a.s.siteapi.org/img/ae2da0526aece652bf42c07028dae4a520833441.png", Constants.DESSERTS,Constants.DESSERTS2Description));
        productRepository.save(new ProductModel(0, "French fries", 200, 1, "https://static.wixstatic.com/media/b907f3_71c4dc92611a48d3b812f431fc51662c.png_srz_490_490_85_22_0.50_1.20_0.00_png_srz", Constants.POTATO,Constants.POTATO1Description));
        productRepository.save(new ProductModel(0, "Rustic potato", 200, 1, "https://uno-pizza.ru/images/fri/fri_dolki.png", Constants.POTATO,Constants.POTATO2Description));
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String rootUrl = req.getContextPath().isEmpty() ? "/" : req.getContextPath();
        String url = req.getRequestURI().substring(req.getContextPath().length());

        if (url.startsWith("/admin")) {
            adminService(req,resp,url);
        }

        if (url.startsWith("/description")) {
            if (req.getMethod().equals("GET")) {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute(Constants.ITEM, burgerUserService.getById(id));
                req.getRequestDispatcher("/WEB-INF/description/frontpage.jsp").forward(req, resp);
                return;
            }

        }

        if (url.equals("/")) {
            userService(req,resp,url);
        }
        if (url.startsWith("/del")) {
             delService(req,resp,url);
        }


    }

    @Override
    public void destroy() {
        log("destroy");
    }

    protected void delService(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException{
        if (req.getMethod().equals("GET")) {
            int id = Integer.parseInt(req.getParameter("id"));
            burgerUserService.delById(id);
            resp.sendRedirect("/");
            return;
        }
    }

//    protected void sortService(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
//        if (req.getMethod().equals("GET")) {
//            HttpSession session = req.getSession();
//            if (session.isNew()) {
//                int orderId = burgerUserService.createOrder();
//                session.setAttribute("order-id", orderId);
//            }
//            req.setAttribute("total-amount", burgerUserService.totalAmount());
//            String orderCategory = req.getParameter("category");
//            int orderId = (Integer) session.getAttribute("order-id");
//            req.setAttribute("ordered-items", burgerUserService.getAllOrderPositionForCategory(orderCategory));
//            List<OrderPositionModel> allOrderPositionForCategory = burgerUserService.getAllOrderPositionForCategory(orderCategory);
//            int i = allOrderPositionForCategory.size();
//            int i2 = allOrderPositionForCategory.size();
//            req.setAttribute(Constants.ITEMS, burgerUserService.getAll());
//            req.getRequestDispatcher("/WEB-INF/user/frontpage.jsp").forward(req, resp);
//            return;
//        }
//    }

    protected void userService(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException{
        if (req.getMethod().equals("GET")) {
            HttpSession session = req.getSession();
            if (session.isNew()) {
                int orderId = burgerUserService.createOrder();
                session.setAttribute("order-id", orderId);
            }
            req.setAttribute("total-amount",burgerUserService.totalAmount());
            int orderId = (Integer) session.getAttribute("order-id");
            req.setAttribute("ordered-items", burgerUserService.getAllOrderPosition(orderId));
            req.setAttribute(Constants.ITEMS, burgerUserService.getAll());
            req.getRequestDispatcher("/WEB-INF/user/frontpage.jsp").forward(req, resp);
            return;
        }
        if (req.getMethod().equals("POST")) {
            HttpSession session = req.getSession();
            if (session.isNew()) {
                int orderId = burgerUserService.createOrder();
                session.setAttribute("order-id", orderId);
            }

            req.setAttribute("total-amount",burgerUserService.totalAmount());
            int orderId = (Integer) session.getAttribute("order-id");
            int id = Integer.parseInt(req.getParameter("id"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            burgerUserService.order(orderId, id, quantity);
            resp.sendRedirect(url);
            return;
        }

    }
    protected void adminService(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException{
        if (url.equals("/admin")) {

            if (req.getMethod().equals("GET")) {
                req.setAttribute(Constants.ITEMS, burgerAdminService.getAll());
                req.getRequestDispatcher("/WEB-INF/admin/frontpage.jsp").forward(req, resp);
                return;
            }

            if (req.getMethod().equals("POST")) {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                int price = Integer.parseInt(req.getParameter("price"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));
                String imageUrl =req.getParameter("imageUrl");
                String category = req.getParameter("category");
                String description = req.getParameter("description");
                burgerAdminService.save(new ProductModel(id, name, price, quantity, imageUrl, category, description));
                resp.sendRedirect(url);
                return;
            }
        }

        if (url.startsWith("/admin/edit")) {
            if (req.getMethod().equals("GET")) {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute(Constants.ITEM, burgerAdminService.getById(id));
                req.setAttribute(Constants.ITEMS, burgerAdminService.getAll());
                req.getRequestDispatcher("/WEB-INF/admin/frontpage.jsp").forward(req, resp);
                return;
            }

        }

        return;

    }
}
