package com.yuhui.core.utils;

import java.io.Serializable;
import java.util.List;

public class JsonTree implements Serializable{

	private static final long serialVersionUID = 2332707604367293413L;

	private String id;
	
	private String name;
	
	private String link;
	
    private boolean isNewWindow;
    
    private List<JsonTree> children;
    
    private boolean isParent;
    
    public JsonTree(){
    }

	public JsonTree(String id, String name, String link, boolean isNewWindow,
			List<JsonTree> children) {
		super();
		this.id = id;
		this.name = name;
		this.link = link;
		this.isNewWindow = isNewWindow;
		this.children = children;
	}
	
	public JsonTree(String id, String name, String link, boolean isNewWindow) {
		super();
		this.id = id;
		this.name = name;
		this.link = link;
		this.isNewWindow = isNewWindow;
	}
	
	public JsonTree(String id, String name, boolean isParent) {
		super();
		this.id = id;
		this.name = name;
		this.isParent = isParent;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public boolean isNewWindow() {
		return isNewWindow;
	}

	public void setNewWindow(boolean isNewWindow) {
		this.isNewWindow = isNewWindow;
	}

	public List<JsonTree> getChildren() {
		return children;
	}

	public void setChildren(List<JsonTree> children) {
		this.children = children;
	}

	public boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(boolean isParent) {
		this.isParent = isParent;
	}
    
    
}
