package com.haoyu.tpdpor.courseresource.listener;

import java.math.BigDecimal;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Component;

import com.haoyu.sip.point.entity.PointStrategy;
import com.haoyu.sip.point.service.IPointStrategyService;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.event.CreateResourceEvent;

@Component
public class CreateResourceListener4Point implements ApplicationListener<CreateResourceEvent> {
	@Resource
	private IPointStrategyService pointStrategyService;

	@Override
	public void onApplicationEvent(CreateResourceEvent event) {
		Resources resource = (Resources) event.getSource();
		if (resource != null && resource.getResourceExtend() != null && resource.getResourceExtend().getPrice() != null) {
			BigDecimal price = resource.getResourceExtend().getPrice();
			if (!price.equals(new BigDecimal(0))) {
				PointStrategy pointStrategy_pay = new PointStrategy();
				pointStrategy_pay.setRelationId("tpdpor");
				pointStrategy_pay.setPoint(price.negate().floatValue());
				pointStrategy_pay.setType("course_resource_pay" + price);
				pointStrategy_pay.setSummary("下载课程案例支付积分");
				try {
					pointStrategyService.createPointStrategy(pointStrategy_pay);
				} catch (DuplicateKeyException e) {

				}
				PointStrategy pointStrategy_accept = new PointStrategy();
				pointStrategy_accept.setRelationId("tpdpor");
				pointStrategy_accept.setPoint(price.floatValue());
				pointStrategy_accept.setType("course_resource_accept" + price);
				pointStrategy_accept.setSummary("上传的课程案例被下载支付");
				try {
					pointStrategyService.createPointStrategy(pointStrategy_accept);
				} catch (DuplicateKeyException e) {

				}

			}
		}

	}

}
