package it.quantyca.kafka.streams;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Join {
    private Integer order_id;
    private String order_data;
    private Integer customer_id;
    private Integer order_detail_id;
    private Integer product_id;
    private Integer quantity;
    private String id;
}
