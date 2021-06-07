package it.quantyca.kafka.streams;

import io.confluent.kafka.serializers.KafkaJsonDeserializer;
import io.confluent.kafka.serializers.KafkaJsonSerializer;
import org.apache.kafka.common.serialization.Deserializer;
import org.apache.kafka.common.serialization.Serde;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.common.serialization.Serializer;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.kstream.*;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.kafka.annotation.EnableKafkaStreams;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

@SpringBootApplication
@EnableKafkaStreams
public class App {

    public static void main(final String[] args) {
        SpringApplication.run(App.class, args);
    }

    @Bean
    KStream<String, Join> join(final StreamsBuilder builder) {

        final KStream<String, Order> leftSource = builder.stream("cdc.orders", Consumed.with(Serdes.String(), getOrderJsonSerde()));
        final KStream<String, OrderDetail> rightSource = builder.stream("cdc.order_details", Consumed.with(Serdes.String(), getOrderDetailsJsonSerde()));

        final KStream<String, Join> joined = leftSource.join(rightSource,
                (leftValue, rightValue) -> new Join(
                        leftValue.getId(),
                        leftValue.getOrder_data(),
                        leftValue.getCustomer_id(),
                        rightValue.getId(),
                        rightValue.getProduct_id(),
                        rightValue.getQuantity()
                ),
                JoinWindows.of(Duration.ofSeconds(30)),
                Joined.with(
                        Serdes.String(),
                        getOrderJsonSerde(),
                        getOrderDetailsJsonSerde()
                )
        );

        joined.to("orders-details-joined", Produced.with(Serdes.String(), getJoinJsonSerde()));

        return joined;
    }

    private static Serde<Order> getOrderJsonSerde(){

        Map<String, Object> serdeProps = new HashMap<>();
        serdeProps.put("json.value.type", Order.class);

        final Serializer<Order> mySerializer = new KafkaJsonSerializer<>();
        mySerializer.configure(serdeProps, false);

        final Deserializer<Order> myDeserializer = new KafkaJsonDeserializer<>();
        myDeserializer.configure(serdeProps, false);

        return Serdes.serdeFrom(mySerializer, myDeserializer);
    }

    private static Serde<OrderDetail> getOrderDetailsJsonSerde(){

        Map<String, Object> serdeProps = new HashMap<>();
        serdeProps.put("json.value.type", OrderDetail.class);

        final Serializer<OrderDetail> mySerializer = new KafkaJsonSerializer<>();
        mySerializer.configure(serdeProps, false);

        final Deserializer<OrderDetail> myDeserializer = new KafkaJsonDeserializer<>();
        myDeserializer.configure(serdeProps, false);

        return Serdes.serdeFrom(mySerializer, myDeserializer);
    }

    private static Serde<Join> getJoinJsonSerde(){

        Map<String, Object> serdeProps = new HashMap<>();
        serdeProps.put("json.value.type", Join.class);

        final Serializer<Join> mySerializer = new KafkaJsonSerializer<>();
        mySerializer.configure(serdeProps, false);

        final Deserializer<Join> myDeserializer = new KafkaJsonDeserializer<>();
        myDeserializer.configure(serdeProps, false);

        return Serdes.serdeFrom(mySerializer, myDeserializer);
    }
}
