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
    <a href="/" style="float: left;  margin-top: 6px; "
       class="btn btn-danger">Back</a>

    <div style="min-height: 60px;"></div>

    <%--    <div class="row " style="max-width: 65%; float: left">--%>
    <% ProductModel item = (ProductModel) request.getAttribute(Constants.ITEM);%>
    <%--        <div class="card mb-3 border border-primary" style="max-width: 340px; margin-left: 10px">--%>
    <%--            <div class="row no-gutters">--%>
    <%--                <div class="col-md-4">--%>
    <%--                    <img src=<%=item.getImageUrl()%> class="card-img" alt="...">--%>
    <%--                </div>--%>
    <%--                <div class="col-md-8">--%>
    <%--                    <div class="card-body">--%>
    <%--                        <h5 class="card-title"><%= item.getName() %>--%>
    <%--                        </h5>--%>
    <%--                        <ul class="list-group list-group-flush">--%>
    <%--                            <li class="list-group-item">Price: <%= item.getPrice() %>--%>
    <%--                            </li>--%>
    <%--                            <li class="list-group-item">Category: <%= item.getCategory() %>--%>
    <%--                            </li>--%>
    <%--                        </ul>--%>
    <%--                        <form action="<%= request.getContextPath() %>" method="post">--%>
    <%--                            <input name="id" type="hidden" value="<%= item.getId() %>">--%>
    <%--                            <div class="form group">--%>
    <%--                                <label for="quantity">Product Quantity</label>--%>
    <%--                                <input type="number" min="0" id="quantity" name="quantity" value="1">--%>
    <%--                            </div>--%>
    <%--                            <button class="btn btn-primary" style=" margin: 5px">Add to card</button>--%>
    <%--                        </form>--%>
    <%--                    </div>--%>
    <%--                </div>--%>
    <%--            </div>--%>
    <%--        </div>--%>
    <%--    </div>--%>


    <div style=" min-width: 100%; min-height: 500px; " class="border border-dark">
        <div style="min-width: 50%; max-width: 50%;  min-height: 500px;float: left;">
            <img src=<%=item.getImageUrl()%> class="card-img" style="max-height: 490px">
        </div>
        <div style="min-width: 50%; float: left; min-height: 490px; max-width: 49%">
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title" style="font-size: 3em; color: red"><%= item.getName() %>
                    </h5>
                    <ul class="list-group list-group-flush" style="font-size: 1.8em">
                        <li class="list-group-item">Price: <%= item.getPrice() %>
                        </li>
                        <li class="list-group-item">Category: <%= item.getCategory() %>
                        </li>
                        <li class="list-group-item">About product :</li>
                    </ul>
                </div>
            </div>
            <div style="font-size: 1.5em; ">
                <p class="text-left"><%=item.getDescription()%></p>
            </div>

        </div>
    </div>
</div>


</body>
</html>
