/**
 * Mybatis实体及dao生成测试
 */
package cn.xcrx.security;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.exception.InvalidConfigurationException;
import org.mybatis.generator.exception.XMLParserException;
import org.mybatis.generator.internal.DefaultShellCallback;

/**
 * Mybatis实体及dao生成测试
 * @author qnwang
 * @version 1.0
 */
public class MybatisGeneratorTest {
	public static void main(String[] args)
			throws IOException, XMLParserException, InvalidConfigurationException, SQLException, InterruptedException {
		List<String> warnings = new ArrayList<String>();
		boolean overwrite = true;
		
		//读取配置文件generatorConfig.xml
//		File configFile = new File("src/main/resources/generatorConfig.xml");
		File configFile = new File("src/main/resources/mybatis-generatorConfig.xml");
									
		ConfigurationParser cp = new ConfigurationParser(warnings);
		Configuration config = cp.parseConfiguration(configFile);
		
		DefaultShellCallback callback = new DefaultShellCallback(overwrite);
		
		MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
		myBatisGenerator.generate(null);
		for (String s : warnings) {
			System.out.println(s);
		}

		System.out.println("生成成功！！！！！");
	}
}
