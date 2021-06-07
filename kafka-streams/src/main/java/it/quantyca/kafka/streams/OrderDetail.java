package it.quantyca.kafka.streams;

import lombok.Data;

@Data
public class OrderDetail {
    private Integer id;
    private Integer order_id;
    private Integer product_id;
    private Integer quantity;
}
