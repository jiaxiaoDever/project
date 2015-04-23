package com.yuhui.core.web.report;



public class ReportTypeNode {

		//id
		private String id;
		
		//父id
		private String parentId;
		
		//名称
		private String name;
		
		//是否叶子
		private boolean isParent;
		

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getParentId() {
			return parentId;
		}

		public void setParentId(String parentId) {
			this.parentId = parentId;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public boolean getIsParent() {
			return isParent;
		}

		public void setIsParent(boolean isParent) {
			this.isParent = isParent;
		}

		
		
		
}
