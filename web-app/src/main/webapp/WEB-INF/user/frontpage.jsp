<%@ page import="java.util.List" %>
<%@ page import="ru.rosbank.javaschool.web.constant.Constants" %>
<%@ page import="ru.rosbank.javaschool.web.model.ProductModel" %>
<%@ page import="ru.rosbank.javaschool.web.model.OrderPositionModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Burger Shop</title>
    <%@include file="../bootstrap-css.jsp" %>
</head>
<body>
<div class="container" style=" min-height: 53px;">
    <h1 align="center">Burger Shop</h1>
<%--    <div style="margin-left: 0px;">--%>
<%--        <a href="<%= request.getContextPath() %>/description?id=1"--%>
<%--           style="float: left;margin-left: 5px;"--%>
<%--           class="btn btn-danger">Burgers</a>--%>
<%--        <a href="<%= request.getContextPath() %>/sort?category=<%=Constants.DRINKS%>"--%>
<%--           style="float: left;margin-left: 5px; "--%>
<%--           class="btn btn-danger">Drinks</a>--%>
<%--        <a href="<%= request.getContextPath() %>/sort?category=<%=Constants.DESSERTS%>"--%>
<%--           style="float: left; margin-left: 5px;"--%>
<%--           class="btn btn-danger">Deserts</a>--%>
<%--        <a href="<%= request.getContextPath() %>/sort?category=<%=Constants.POTATO%>"--%>
<%--           style="float: left; margin-left: 5px;"--%>
<%--           class="btn btn-danger">Potato</a>--%>

<%--    </div>--%>
    <div style="min-height: 60px;"></div>
    <div class="row " style="max-width: 65%; float: left">
        <% for (ProductModel item : (List<ProductModel>) request.getAttribute(Constants.ITEMS)) { %>
        <div class="card mb-3 border border-primary" style="max-width: 340px; margin-left: 10px">
            <div class="row no-gutters">
                <div class="col-md-4">
                    <img src=<%=item.getImageUrl()%> class="card-img" alt="...">
                </div>
                <div class="col-md-8">
                    <div class="card-body">
<%--                        <h5 class="card-title"><%= item.getName() %>--%>
<%--                        </h5>--%>
                        <a href="<%= request.getContextPath() %>/description?id=<%= item.getId()%>"
                           style="font-size: 1.5em; color: black"
                           class=""><%= item.getName() %></a>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Price: <%= item.getPrice() %>
                            </li>
                            <li class="list-group-item">Category: <%= item.getCategory() %>
                            </li>
                        </ul>
                        <form action="<%= request.getContextPath() %>" method="post">
                            <input name="id" type="hidden" value="<%= item.getId() %>">
                            <div class="form group">
                                <label for="quantity">Product Quantity</label>
                                <input type="number" min="0" id="quantity" name="quantity" value="1">
                            </div>
                            <button class="btn btn-primary" style=" margin: 5px">Add to card</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>


    <div class="border border-dark"
         style="background: #f2f3ff; float: left; margin-left: 20px; min-width: 35%; align-content: center;">
        <div class="border border-dark" style="margin: 5px; height: 100%;">
            <h1 style="" align="center"> Card</h1>
            <% List<OrderPositionModel> positions = (List<OrderPositionModel>) request.getAttribute("ordered-items"); %>
            <% for (OrderPositionModel model : positions) { %>
            <div>

                <a href="<%= request.getContextPath() %>/del?id=<%= model.getId()%>"
                   style="float: left; min-width: 49%; max-width: 50%; margin-top: 6px; margin-right: 1%"
                   class="btn btn-danger">Del</a>

                <div style="float: left; background: #fdf0ff;max-width: 50%; min-width: 50%; margin-top: 6px;"
                     class="border border-dark mb-2 bg-primary text-white">
                    <div><%= model.getProductName()%>
                    </div>
                    <div><%= model.getProductPrice()%> x <%= model.getProductQuantity()%>
                        = <%= model.getProductPrice() * model.getProductQuantity()%>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <div style="min-width: 100%; font-size: 2em; font-family: 'Rage Italic';">
            Total amount: <%=request.getAttribute("total-amount")%> rub.
        </div>
    </div>

</div>

</body>
</html>
