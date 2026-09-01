package com.microfinance.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import com.microfinance.interceptor.ActivityInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private ActivityInterceptor activityInterceptor;

    @Value("${upload.directory:C:/Users/Hp/OneDrive/Desktop/project1/SamithUrban/src/main/webapp/Uploads}")
    private String uploadDirectory;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(activityInterceptor).addPathPatterns("/api/**");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String path = uploadDirectory.replace("\\", "/");
        if (!path.endsWith("/")) {
            path += "/";
        }
        registry.addResourceHandler("/Uploads/**")
                .addResourceLocations("file:" + path, "/Uploads/");
    }
}
