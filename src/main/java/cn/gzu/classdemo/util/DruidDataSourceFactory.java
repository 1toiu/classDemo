package cn.gzu.classdemo.util;

import com.alibaba.druid.pool.DruidDataSource;
import org.apache.ibatis.datasource.DataSourceFactory;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class DruidDataSourceFactory implements DataSourceFactory {
    private final DruidDataSource dataSource = new DruidDataSource();

    @Override
    public void setProperties(Properties properties) {
        try (InputStream in = DruidDataSourceFactory.class.getClassLoader().getResourceAsStream("druid.properties")) {
            if (in != null) {
                Properties druid = new Properties();
                druid.load(in);
                dataSource.configFromPropety(druid);
            }
        } catch (IOException e) {
            throw new IllegalStateException("读取 druid.properties 失败", e);
        }
        dataSource.setDriverClassName(properties.getProperty("driver"));
        dataSource.setUrl(properties.getProperty("url"));
        dataSource.setUsername(properties.getProperty("username"));
        dataSource.setPassword(properties.getProperty("password"));
    }

    @Override
    public DataSource getDataSource() {
        return dataSource;
    }
}
