/**

 * @Title: ActivityController.java

 * @Package com.by.controller

 * @Description: TODO

 * Copyright: Copyright (c) 2016 

 * Company:Joymap

 * 

 * @author Carl

 * @date 2016年12月8日 下午2:19:58

 * @version V1.0

 */



package com.by.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**

  * @ClassName: ActivityController

  * @Description: TODO

  * @author Joymap-Carl

  * @date 2016年12月8日 下午2:19:58

  *
  */
@Controller
@RequestMapping(value = "/api/activityCoupons")
public class ActivityController {
		private List<Integer> activityShops = new ArrayList<Integer>();
		
		
}
