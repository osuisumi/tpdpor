package com.haoyu.tpdpor.freemaker.util;


import java.lang.annotation.Annotation;
import java.util.Map;


import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;

import com.google.common.collect.Maps;
import com.haoyu.sip.core.freemarker.TemplateDirective;

import freemarker.template.TemplateDirectiveModel;

public class FreemarkerVariablesFactory  implements BeanPostProcessor{
	
	public Map<String,Object> freemarkerVariables = Maps.newHashMap();

	public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
		if(bean instanceof TemplateDirectiveModel){
			Annotation templateDirectiveAnnotation = getMyAnnotation(bean.getClass().getAnnotations(),TemplateDirective.class.getName());
			String directiveName = firstCharLowerCase(beanName);
			if(templateDirectiveAnnotation != null){
				TemplateDirective templateDirective = (TemplateDirective) templateDirectiveAnnotation;
				directiveName = templateDirective.directiveName().equals("")?firstCharLowerCase(beanName):templateDirective.directiveName();
			}
			if(freemarkerVariables.containsKey(directiveName)){
				throw new RuntimeException("directiveName " + directiveName + "has been useed,check "+bean.getClass() + "'s directiveName");
			}else{
				freemarkerVariables.put(directiveName, bean);
			}
		}
		return bean;
	}

	private Annotation getMyAnnotation(Annotation[] annotations,String annotationName){
		if (annotations == null) {
			return null;
		}
		for (Annotation annotation : annotations) {
			if (annotation.annotationType().getName().equals(annotationName)) {
				return annotation;
			}
		}
		return null;
	}

	public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
		return bean;
	}
	
	private String firstCharLowerCase(String beanName){
		String first = String.valueOf(beanName.charAt(0));
		return beanName.replaceFirst(first, first.toLowerCase());
	}

}

