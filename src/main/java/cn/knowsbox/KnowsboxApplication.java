package cn.knowsbox;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

/**
 * 启动类
 * 在启动类中添加@EnableCaching，开启缓存功能，否则出现多类不能同时写入缓存
 * 
 * @author turkey
 *
 *         2017年4月18日
 */
@SpringBootApplication
@EnableCaching  // 开启缓存功能
public class KnowsboxApplication {
	public static void main(String[] args) {
		SpringApplication.run(KnowsboxApplication.class, args);
	}

}
