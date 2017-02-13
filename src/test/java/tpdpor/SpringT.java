package tpdpor;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.haoyu.tpdpor.resource.service.IResourceWsService;


public class SpringT {
	
	public static void main(String[] args) {
		ApplicationContext acc = new ClassPathXmlApplicationContext("applicationContext.xml");
		IResourceWsService resourceWsService = (IResourceWsService) acc.getBean("resourceWsService");
		System.out.println(resourceWsService.list(1, 100));
//		System.out.println(acc.getBean("bookIndexDao"));;
	}

}
