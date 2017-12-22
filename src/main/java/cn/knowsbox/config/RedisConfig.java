package cn.knowsbox.config;

import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;

import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.GenericToStringSerializer;


import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;



@Configuration
@EnableCaching //开启spring session 支持，实现session共享
public class RedisConfig extends CachingConfigurerSupport {

	private int expireTime;

	// 缓存数据时Key的生成器，可以依据业务和技术场景自行定制
	@Bean
	@ApiOperation("可以单独作为非数据类型的keyGenerator")
	public KeyGenerator keyGenerator() {
		return new KeyGenerator() {
			@Override
			public Object generate(Object target, Method method, Object... params) {
				StringBuilder sb = new StringBuilder();
				// 类名+方法名
				sb.append(target.getClass().getName());
				sb.append(method.getName() + ":");
				for (Object obj : params) {
					sb.append(obj.toString());
				}
				return sb.toString();
			}
		};
	}

	@Bean
	@ApiOperation("单独作为数据类型的keyGenerator")
	public KeyGenerator objectId() {
		return new KeyGenerator() {
			@Override
			public Object generate(Object target, Method method, Object... params) {
				StringBuilder sb = new StringBuilder();
				sb.append(target.getClass().getName()+":");
				try {
					sb.append(params[0].getClass().getMethod("getId", null).invoke(params[0], null).toString());
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				} catch (IllegalAccessException il) {
					il.printStackTrace();
				} catch (InvocationTargetException iv) {
					iv.printStackTrace();
				}
				return sb.toString();
			}
		};
	}

	@SuppressWarnings("rawtypes")
	@Bean
	@ApiOperation(value = "设置缓存过期时间")
	public CacheManager cacheManager(RedisTemplate redisTemplate) {
		RedisCacheManager rcm = new RedisCacheManager(redisTemplate);
		//设置缓存过期时间
		rcm.setDefaultExpiration(expireTime);//秒，便于测试 43200=12h
		return rcm;
	}

	/**
	 * Redis 初始化
	 */
	@Bean
	public RedisTemplate redisTemplate(RedisConnectionFactory factory) {
		RedisTemplate redis = new RedisTemplate();
		// GenericToStringSerializer 可以将任何对象泛化为字符串并序列化
		// 设置键（key）的序列化采用 GenericToStringSerializer
//		StringRedisSerializer: 简单的字符串序列化
		GenericToStringSerializer<String> keySerializer = new GenericToStringSerializer<String>(String.class);
		redis.setKeySerializer(keySerializer);
		redis.setHashKeySerializer(keySerializer);
		// 设置值（value）的序列化采用 Jackson2JsonRedisSerializer
		GenericJackson2JsonRedisSerializer valueSerializer = new GenericJackson2JsonRedisSerializer();
		redis.setValueSerializer(valueSerializer);
		redis.setHashValueSerializer(valueSerializer);
		redis.setConnectionFactory(factory);
		return redis;
	}
}

