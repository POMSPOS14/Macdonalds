<%@ page import="java.util.List" %>
<%@ page import="ru.rosbank.javaschool.web.constant.Constants" %>
<%@ page import="ru.rosbank.javaschool.web.model.ProductModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Dashboard</title>
    <%@include file="../bootstrap-css.jsp" %>
</head>
<body>

<div class="container">
    <h1>Dashboard</h1>


    <% for (ProductModel item : (List<ProductModel>) request.getAttribute(Constants.ITEMS)) { %>
    <div class="card border border-primary" style="width: 18rem; float: left; margin-right: 5px; margin-bottom: 5px;">
        <div class="card-body">
            <h5 class="card-title"><%= item.getName() %>
            </h5>
            <ul class="list-group list-group-flush">
                <li class="list-group-item">Price: <%= item.getPrice() %>
                </li>
                <li class="list-group-item">Quantity: <%= item.getQuantity() %>
                </li>
                <li class="list-group-item">Category: <%= item.getCategory() %>
                </li>
                <li class="list-group-item">Description: <%= item.getDescription() %>
                </li>

            </ul>
            <a href="<%= request.getContextPath() %>/admin/edit?id=<%= item.getId()%>" class="btn btn-primary">Edit</a>
        </div>
    </div>
    <% } %>


    <% if (request.getAttribute(Constants.ITEM) == null) { %>
    <form action="<%= request.getContextPath() %>/admin" method="post">
        <input name="id" type="hidden" value="0">
        <div class="form group">
            <label for="name">Product Name</label>
            <input type="text" id="name" name="name">
        </div>
        <div class="form group">
            <label for="price">Product Price</label>
            <input type="number" min="0" id="price" name="price">
        </div>
        <div class="form group">
            <label for="quantity">Product Quantity</label>
            <input type="number" min="0" id="quantity" name="quantity">
        </div>
        <div class="form group">
            <label for="category">Product Category</label>
            <select name="category" style="margin-top: 2px;">
                <option value="<%=Constants.BURGERS%>">burgers</option>
                <option value="<%=Constants.DRINKS%>">drinks</option>
                <option value="<%=Constants.DESSERTS%>">desserts</option>
                <option value="<%=Constants.POTATO%>">potato</option>
            </select>
        </div>
        <div class="form group">
            <label for="description">Product Description</label>
            <input type="text" id="description" name="description">
        </div>

        <button class="btn btn-primary">Add</button>
    </form>
    <% } %>

    <% if (request.getAttribute(Constants.ITEM) != null) { %>
    <% ProductModel item = (ProductModel) request.getAttribute(Constants.ITEM); %>
    <form action="<%= request.getContextPath() %>/admin" method="post">
        <input name="id" type="hidden" value="<%= item.getId() %>">
        <div class="form group">
            <label for="name">Product Name</label>
            <input type="text" id="name" name="name" value="<%= item.getName() %>">
        </div>
        <div class="form group">
            <label for="price">Product Price</label>
            <input type="number" min="0" id="price" name="price" value="<%= item.getPrice() %>">
        </div>
        <div class="form group">
            <label for="quantity">Product Quantity</label>
            <input type="number" min="0" id="quantity" name="quantity" value="<%= item.getQuantity() %>">
        </div>
        <div class="form group">
            <label for="category">Product Category</label>
            <select name="category">
                <option value="<%=Constants.BURGERS%>">burgers</option>
                <option value="<%=Constants.DRINKS%>">drinks</option>
                <option value="<%=Constants.DESSERTS%>">desserts</option>
                <option value="<%=Constants.POTATO%>">potato</option>
            </select>
        </div>
        <div class="form group">
            <label for="description">Product Category</label>
            <input type="text" id="description" name="description" value="<%=item.getDescription()%>">
        </div>


        <button class="btn btn-primary">Save</button>


    </form>
    <% } %>


</div>

</body>
</html>
