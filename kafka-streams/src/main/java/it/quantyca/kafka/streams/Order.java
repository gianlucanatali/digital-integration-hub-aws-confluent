package it.quantyca.kafka.streams;

import lombok.Data;

@Data
public class Order {
    private Integer id;
    private String order_data;
    private Integer customer_id;
}
