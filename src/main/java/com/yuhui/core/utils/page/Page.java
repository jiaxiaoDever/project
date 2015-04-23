package com.yuhui.core.utils.page;

import java.util.Collections;
import java.util.List;

/**
 * 
* @ClassName: Page 
* @Description: 分页结果object
* @author xiexiaozhi 
* @date 2013-9-18 下午1:45:44 
*
 */
public class Page<T>  {
	
	   
	   	private int pageSize;
	    private int currentPage;
	   
	    private int totalPage;
	    private int totalCount;
	    
		//-- 返回结果 --//
		protected List<T> result = Collections.emptyList();
		
		
		public Page(PageParameter param){
			
			this.setParams(param);
			
		}
		
		public Page(PageParameter param,List<T> result){
			
			this.result = result ;
			this.setParams(param);
		}
		
	
		public int getPageSize() {
			return pageSize;
		}
	
		public int getCurrentPage() {
			return currentPage;
		}
	
		public int getTotalPage() {
			return totalPage;
		}
	
		public int getTotalCount() {
			return totalCount;
		}

		
		public List<T> getResult() {
			return result;
		}

		/**
		 * 设置页内的记录列表.
		 */
		public void setResult(final List<T> result) {
			this.result = result;
		}
		
		private void setParams(PageParameter param){
			this.pageSize = param.getPageSize();
			this.currentPage = param.getCurrentPage();
			this.totalCount = param.getTotalCount();
			this.totalPage = param.getTotalPage();
		}
}
