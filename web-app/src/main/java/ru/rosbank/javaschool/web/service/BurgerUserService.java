package ru.rosbank.javaschool.web.service;

import lombok.RequiredArgsConstructor;
import ru.rosbank.javaschool.web.exception.NotFoundException;
import ru.rosbank.javaschool.web.model.OrderModel;
import ru.rosbank.javaschool.web.model.OrderPositionModel;
import ru.rosbank.javaschool.web.model.ProductModel;
import ru.rosbank.javaschool.web.repository.OrderPositionRepository;
import ru.rosbank.javaschool.web.repository.OrderRepository;
import ru.rosbank.javaschool.web.repository.ProductRepository;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
public class BurgerUserService {
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;
    private final OrderPositionRepository orderPositionRepository;

    public List<ProductModel> getAll() {
        return productRepository.getAll();
    }

    public ProductModel getById(int id) {
        return productRepository.getById(id).orElseThrow(NotFoundException::new);
    }


    public int createOrder() {
        OrderModel model = new OrderModel(0);
        orderRepository.save(model);
        return model.getId();
    }

    public void order(int orderId, int id, int quantity) {
        ProductModel productModel = productRepository.getById(id).orElseThrow(NotFoundException::new);
        OrderPositionModel orderPositionModel = new OrderPositionModel(
                0,
                orderId,
                productModel.getId(),
                productModel.getName(),
                productModel.getPrice(),
                quantity,
                productModel.getCategory(),
                productModel.getDescription()
        );
        orderPositionRepository.save(orderPositionModel);
    }

    public int totalAmount() {
        List<OrderPositionModel> all = orderPositionRepository.getAll();
        int sum = 0;
        for (OrderPositionModel orderPositionModel : all) {
            sum = sum + orderPositionModel.getProductPrice() * orderPositionModel.getProductQuantity();
        }
        return sum;
    }



    public void delById(int id) {
        orderPositionRepository.removeById(id);
    }

    public List<OrderPositionModel> getAllOrderPosition(int orderId) {
        return orderPositionRepository.getAllByOrderId(orderId);
    }

    public List<OrderPositionModel> getAllOrderPositionForCategory(String category) {
        List<OrderPositionModel> all = orderPositionRepository.getAll();
        return all.stream()
                .filter(o -> o.getProductCategory().toLowerCase().equals(category.toLowerCase()))
                .collect(Collectors.toList());
    }
}
