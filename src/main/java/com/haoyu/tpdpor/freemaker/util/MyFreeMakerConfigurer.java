package com.haoyu.tpdpor.freemaker.util;



import java.util.Map;

public class MyFreeMakerConfigurer extends org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer {
	private FreemarkerVariablesFactory freemarkerVariablesFactory;

	public void setFreemarkerVariables(Map<String, Object> variables) {
		variables.putAll(freemarkerVariablesFactory.freemarkerVariables);
		super.setFreemarkerVariables(variables);
	}

	public void setFreemarkerVariablesFactory(FreemarkerVariablesFactory freemarkerVariablesFactory) {
		this.freemarkerVariablesFactory = freemarkerVariablesFactory;
	}

}
