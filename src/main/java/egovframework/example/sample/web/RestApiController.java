package egovframework.example.sample.web;

import egovframework.example.sample.service.SampleVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

/**
 * Created by kth on 2017-12-08.
 */

@RestController
@RequestMapping("/api")
public class RestApiController {

    public static final Logger logger = LoggerFactory.getLogger(RestApiController.class);

    @RequestMapping("/")
    public String welcome() {
        return "Welcome to RestTemplate Example.";
    }

    @ResponseBody
    @RequestMapping(value="/egovSampleList/{id}", method= RequestMethod.GET)
    public SampleVO egovList(@PathVariable String id) {
        SampleVO sample = new SampleVO(id, "Runtime Environment", "Foundation Layer", "Y", "eGov");
        return sample;
    }
}
