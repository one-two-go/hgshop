import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bawei.hgshop.service.SpuService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:applicationContext-es.xml","classpath:applicationContext-service.xml","classpath:applicationContext-dao.xml","classpath:applicationContext-redis.xml","classpath:applicationContext-kafka-provider.xml","classpath:applicationContext-kafka-consumer.xml"})
public class ESTest {
//	@Reference(url="dubbo://localhost:20890",timeout=5000)
	@Autowired
	private SpuService spuService;
	
	
	
	@Test
	public void testSave() {
		try {
			spuService.saveOrUpdateESSpu(7);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testSearch() {
		Map<String, String> filter = new HashMap<>();
		
		filter.put("categoryId", "1252");
		
		Map<String, Object> search = spuService.search("衣服", 1, 3, filter);
		System.err.println(search);
		
	}
}
