/**
 * 系统菜单服务对象，用来产生系统菜单，并提供对菜单的一些列操作
 * 需要 ext-base.js 和 ext-all.js 文件的支持
 * @author luoyulong
 * @version 1.0, 2010-8-20
 *                1.0.1 2010-10-9 添加 Ext.app.tsd.getNowTree、Ext.app.tsd.clickNodeById 方法
 *                1.0.2 2010-11-16 添加 针对报表配置页面的菜单展示方式，Ext.app.tsd.TsdTreeLoader方法中增加针对报表页面展示用的条件判断及处理
 */
;(function(){

if(!Ext.app.tsd)Ext.app.tsd={};
/**
 * 方法名：treeRender
 * 描述：将有指定ID的元素构造成树形结构的菜单
 * @param {String} p_el 元素ID
 * @param {String} p_menu_type 菜单类型(show,update,power,report)
 */
Ext.app.tsd.treeRender = function(p_el,p_menu_type){
	if(!p_el)p_el="";
	if(!p_menu_type)p_menu_type='show';
	Ext.DEFAULT_IMAGE_URL="plug-in/extjs/resources/images/default/";
	Ext.BLANK_IMAGE_URL=Ext.DEFAULT_IMAGE_URL+"s.gif";
	Ext.app.tsd.TREE_IS_UPDATE = false;//是否被修改过
	//Ext.onReady(function(){
	    
		//默认样式数组
		Ext.app.tsd.TREE_DEFAULT_STYLE = ["",
		     "x-tree-node-el x-unselectable tree-node-level-1 x-tree-node-leaf ",
		     "x-tree-node-el x-unselectable tree-node-level-2 x-tree-node-leaf ",
		     "x-tree-node-el x-unselectable tree-node-level-3 x-tree-node-leaf ",
		     "x-tree-node-el x-unselectable tree-node-level-4 x-tree-node-leaf "
		];
		
		//获得当前树控件
		Ext.app.tsd.getNowTree = function(){
			return tree;
		};
		
		//根据ID点击节点
		Ext.app.tsd.clickNodeById = function(id){
			var node = tree.getNodeById(id);
			tree.fireEvent("click",node);
		};
		
		//先序遍历节点所有子节点，可以注入一个方法来对节点进行处理
		Ext.app.tsd.traversingNode = function(n,f){
			f(n);
			if(n.hasChildNodes()){
				for(var i=0;i<n.childNodes.length;i++){
					Ext.app.tsd.traversingNode(n.childNodes[i],f);
				}
			}
		};
		
		//追溯出节点的父节点，最终到达root节点
		Ext.app.tsd.retrospectNode = function(n,f){
			f(n);
			if(n.parentNode){
				Ext.app.tsd.retrospectNode(n.parentNode,f);
			}
		};
		
		//重新给树中节点赋序号
		Ext.app.tsd.reloadIndex = function(){
			var i=0;
			Ext.app.tsd.traversingNode(root,function(n){
				n.attributes.iorder=i;
				i++;
			});
		};
		//计算出指定菜单项的开始(当前节点)和结束序号(最后一个子节点)，返回一个对象如:{begin:1,end:10}
		Ext.app.tsd.getBeginEnd = function(n){
			var niorders = [];
			Ext.app.tsd.traversingNode(n,function(node){
				niorders.push(node.attributes.iorder);
			});
			var b=niorders[0],e=niorders[niorders.length-1];
			return {begin:b,end:e};
		};
					
		//查询出指定节点在当前树中的序号
		Ext.app.tsd.nodeIndexOf = function(node){
			var index = 0, i = 0;
			Ext.app.tsd.traversingNode(root,function(n){
				if(n.id===node.id){
					index=i;
					return;
				}
				i++;
			});
			return index;
		}
		
		//查找当前节点下是否有指定级的节点,有返回true 否则false
		Ext.app.tsd.findLevel = function(n,level){
			var r=false;
			var f=function(n){
				if (n.getDepth() == level) {
					r = true;
					return;
				}
				if (n.hasChildNodes())
					for (var i = 0; i < n.childNodes.length; i++) {
						f(n.childNodes[i]);
					}
			};
			f(n);
			return r;
		}
		//遍历所有节点，生成当前树结构的JSON描述形式
		Ext.app.tsd.treeToJSON = function(){
			return Ext.app.tsd.nodeToJSON(root);
		};
		//层序遍历节点
		Ext.app.tsd.nodeToJSON = function(node){
			var c=1, ss;
			var f=function(n){
				var s=(n.isRoot?[]:['{iorder:',(c++),',level:',n.getDepth(),',leaf:"',n.leaf,'",id:"',n.id,'",text:"',n.text,'",href:"',n.attributes.href,'",icon:"',n.attributes.icon,'",hidden:"',n.hidden,'"},']);
				if(n.hasChildNodes())
					for(var i=0;i<n.childNodes.length;i++)
						s.push(f(n.childNodes[i]));
				return s.join('');
			};
			ss=f(node);
			ss=ss.substring(ss,ss.length-1);
			return ['[',ss,']'].join('');
		}
		//移除其它节点的插入占位虚线
		Ext.app.tsd.removeInsertFlag=function(){
			Ext.app.tsd.traversingNode(root,function(node){
				if(!node.isRoot)
					Ext.Element.fly(node.getUI().elNode).removeClass('x-tree-insert-flag');
			});
		};
	    var Tree = Ext.tree;
	    var groupid = document.getElementById('groupid');
	    //继承默认加载对象，重写创建节点的方法，以支持系统框架
	    Ext.app.tsd.TsdTreeLoader = Ext.extend(Tree.TreeLoader, {
	    	createNode:function(attr){
		    	attr.cls = Ext.app.tsd.TREE_DEFAULT_STYLE[attr.level];//根据节点级别设置样式
		    	attr.leaf = attr.children.length>0?false:true;//是否是叶子节点，用来判断是否有子节点
		    	attr.singleClickExpand = true;//是否单击展开节点
				if(p_menu_type=='show'){//如果只是显示菜单
		    		if(attr.children.length>0){//attr.level==1
		    			attr.href=null;
		    		}
		    		if(!attr.leaf){
		    			for(var i=0;i<attr.children.length;i++){
		    				var c = attr.children[i];
		    				//c._href = c.href;//保存原始的href，并将href修改成系统支持的格式
							c._href =[c.href,"&imenuid=",c.id,"&pmenuname=",encodeURIComponent(attr.text),"&imenuname=",encodeURIComponent(c.text),"&groupid=",groupid.value].join('');
		    				c.href=["javascript:jumpPage('",c._href,"');"].join('');
		    			}
		    		}
		    	}else if(p_menu_type=='update'){//如果是需要修改菜单
					attr.href=null;
					attr.hidden=false;//不隐藏菜单
		    	}else if(p_menu_type=='power'){//如果是设置菜单权限
					attr.href=["javascript:getSpower(",attr.id,");"].join("");
					attr.hidden=false;
		    		attr.checked=false;
					attr.disabled = true;
				}else if(p_menu_type=='report'){//如果是报表配置
					//定义标识
					var r_flag = false;
					//将所有节点设置为显示状态
					attr.hidden=false;
					//判断不为节点时
					if(!attr.leaf){
						//将菜单url置空
						attr.href=null;
						//遍历子节点
						for(var i=0;i<attr.children.length;i++){
							//获取子节点对象
		    				var c = attr.children[i];
		    				/**
		    				//判断子节点的地址为通用jsp地址时将标识设为隐藏状态
		    				if(c.href == 'pubMode/SingleTabE.jsp'){
								c.r_flag = r_flag = false;
							
							}else 
							*/
							//判断子节点的地址为通用报表配置地址时将标识设为不隐藏状态
							if (c.href == 'myfavorites/Report.jsp') {
								//向函数中传入菜单id，菜单名称以及是否为通用报表配置标识(Y为是N为不是)
								c.href = ["javascript:menuChecked('", c.id, "','", c.text, "','Y');"].join("");
								//设置非隐藏状态
								c.r_flag = r_flag = true;
							//将其他情况设置为不隐藏状态
							} else {
								//向函数中传入菜单id，菜单名称以及是否为通用报表配置标识(Y为是N为不是)
								c.href = ["javascript:menuChecked('", c.id, "','", c.text, "','N');"].join("");
								//设置非隐藏状态
								c.r_flag = r_flag = true;
							}
						}
					}
					//判断状态是否隐藏attr.hidden=false为显示=true为隐藏
					if(r_flag||attr.r_flag){
						attr.hidden=false
					}else{
						attr.hidden=true;
					}
					
				}
	    		
	    		return Ext.app.tsd.TsdTreeLoader.superclass.createNode.call(this, attr);
	    	}
		}); 
//        Ext.override(Ext.tree.AsyncTreeNode, {
//            select: function(){
//				alert('test');
//			}
//        });
		//重写TreeNodeUI的双击方法
        Ext.override(Ext.tree.TreeNodeUI, {
            onDblClick: function(e){
                e.preventDefault();
                if (this.disabled) {
                    return;
                }
                if (this.checkbox) {
                    //this.toggleCheck();这里不自动选择复选框
                }
                if (!this.animating && this.node.hasChildNodes()) {
                    var isExpand = this.node.ownerTree.doubleClickExpand;
                    if (isExpand) {
                        this.node.toggle();
                    }
                }
                this.fireEvent("dblclick", this.node, e);
            }
        });
		
		//声明加载树数据的对象
		var treeLoader = new Ext.app.tsd.TsdTreeLoader({
			dataUrl:['mainServlet.html?',
				'ds=tsdBilling&tsdcf=mssql&packgname=service&clsname=SysMenuService&method=service&operate=show',
				'&menutype=',p_menu_type,
				'&t=',new Date().getTime()].join('')
		});
		
		//声明一个树控件
	   	var tree = new Tree.TreePanel({
	    	cls: "tsd-tree-panel",
	        el: p_el,
	        border: false,
	        autoScroll:false,
	        containerScroll: false,
	        animate:false,
	        enableDD: (p_menu_type=='update'?true:false),//控制是否允许拖动，只有在更新的时候才允许拖动
	        rootVisible:false,
	        loader: treeLoader
	    });

		//如果是生成可修改的菜单则
		if (p_menu_type=='update') {
			//注册右键菜单
			tree.contextMenu = new Ext.menu.Menu({
				items: [new Ext.menu.Item({
					href:'javascript:void(0);',
					id: 'node-add',
					text: '添加同级菜单项',
					icon: Ext.DEFAULT_IMAGE_URL+'dd/drop-add.gif'
				}), new Ext.menu.Item({
					href:'javascript:void(0);',
					id: 'node-update',
					text: '修改菜单项'
				}), new Ext.menu.Item({
					href:'javascript:void(0);',
					id: 'node-del',
					text: '删除菜单项'
				})],
                listeners: {
                    itemclick: function(item,e){
						Ext.app.tsd.removeInsertFlag();//移除占位符
						var n = item.parentMenu.contextNode;
                        switch (item.id) {
                            case 'node-del':
								delMenu(n.id,n);
                                break;
							case 'node-add':
								//给当前节点添加占位虚线
								var elNode = n.getUI().elNode;
								Ext.Element.fly(elNode).addClass('x-tree-insert-flag');
								addMenu(n);//在当前菜单上面添加新菜单
								break;
							case 'node-update':
								loadUpdateMenu(n.id,n);
								break;
                        }
						item.parentMenu.hide();
						return false;
                    }
                }
			});
			
			//注册菜单事件
			tree.on('contextmenu', function(n, e){
				e.stopEvent();//停止全局右键菜单
				var _c = n.getOwnerTree().contextMenu;//获得菜单
				n.select();
				_c.contextNode = n;//关联菜单
				_c.showAt(e.getXY());
				_ft = _c = null;
			});
		}else if(p_menu_type == 'power'){//如果是设置权限
			//注册节点点击事件
            tree.on('checkchange', function(node, checked){
				Ext.app.tsd.traversingNode(node, function(n){
					if(checked)n.expand();
					if (n.ui.checkbox) {
						n.attributes.checked = checked;
						n.ui.checkbox.checked = checked;
					}
				});
				if (checked) {
					Ext.app.tsd.retrospectNode(node,function(n){
						if (n.ui.checkbox) {
							n.attributes.checked = true;
							n.ui.checkbox.checked = true;
						}
					});
				}
            });
		}

		/**
		 * 选择/取消选择 所有节点
		 * @param {Boolean} checked
		 */
		tree.checkedAll = function(checked){
			if(checked == undefined)
				checked=true;
			root.fireEvent('checkchange', root, checked);
		};
		
		/**
		 * 根据菜单ID选择节点
		 * @param {Array} ids
		 */
		tree.checkedByIdList = function(ids){
			//alert(ids);
			Ext.app.tsd.traversingNode(root,function(n){
				if (n.ui.checkbox) {//先取消节点选择
					n.attributes.checked = false;
					n.ui.checkbox.checked = false;
				}
				//再判断是否选择节点
				var isChecked = false;
				for(var i=0;i<ids.length;i++){
					if(ids[i]==n.attributes.id){
						isChecked = true;
						break;
					}
				}
				if (isChecked && n.ui.checkbox) {
					n.attributes.checked = true;
					n.ui.checkbox.checked = true;
				}
			});
		};

		/**
		 * 获得当前选中的所有节点的ID
		 * @return 拼接好的节点串
		 */
		tree.getAllCheckId = function(){
			var nodes = [];
			Ext.app.tsd.traversingNode(root,function(n){
				if(n.ui.checkbox && n.ui.checkbox.checked==true)
					nodes.push(n.attributes.id);
			});
			return nodes.join(',');
		};
		
		//当点击某节点的时候
	   	tree.on('click',function(n,e){
			tree.getSelectionModel().select(n);//选择节点
			if (p_menu_type=='show') {
				if (n.attributes._href && n.attributes.href != null) {
					if(e)e.stopEvent();
					jumpPage(n.attributes._href);//页面跳转
				}
			}else if (p_menu_type=='update'){
				//当在菜单管理的时候点击菜单就直接显示出信息
				Ext.app.tsd.removeInsertFlag();
				getMenuInfo(n.id);
			}
			Ext.app.tsd.traversingNode(root,function(node){
				if(node.ui.elNode)
					Ext.Element.fly(node.ui.elNode).removeClass(['tree-node-level-1-select','tree-node-level-2-select','tree-node-level-3-select','tree-node-level-4-select']);
			});
			
			//console.log(n);
			var eln = Ext.Element.fly(n.ui.elNode);
			if(n.getDepth()==1){
				eln.addClass('tree-node-level-1-select');
			}
			if(n.getDepth()==2){
				eln.addClass('tree-node-level-2-select');
				Ext.Element.fly(n.parentNode.ui.elNode).addClass('tree-node-level-1-select');
			}
			if(n.getDepth()==3){
				eln.addClass('tree-node-level-3-select');
				Ext.Element.fly(n.parentNode.ui.elNode).addClass('tree-node-level-2-select');
				Ext.Element.fly(n.parentNode.parentNode.ui.elNode).addClass('tree-node-level-1-select');
			}
			
			if(n.getDepth()==4){
				eln.addClass('tree-node-level-4-select');
				Ext.Element.fly(n.parentNode.ui.elNode).addClass('tree-node-level-3-select');
				Ext.Element.fly(n.parentNode.parentNode.ui.elNode).addClass('tree-node-level-1-select');
			}
			
	   		//if(n.getDepth()==3){
	   			//console.log(n.text);
	   			//console.log(n.parentNode.text);
	   			//console.log(n.parentNode.parentNode.text);
	   			//n.setText('测试');
	   			//n.text = n.ui.textNode.innerText = '菜单项名称';
				/*
				var imgHtmlEl = treeNode.getUI().getIconEl(); 
				treeNode.iconCls = newIconCls;
				Ext.Element.fly(imgHtmlEl).removeClass(oldIconCls);
				Ext.Element.fly(imgHtmlEl).addClass(newIconCls);
				*/
		   	//}
		});
	
		//当节点被拖动到目标节点的时候触发
		tree.on('nodedragover',function(e){
			var now = e.dropNode;//当前节点
			var target = e.target;//目标节点
			var n_level = now.getDepth();//当前节点深度
			var t_level = target.getDepth();//目标节点深度
			var exist_level_2 = Ext.app.tsd.findLevel(now,2);//是否存在2级节点
			var exist_level_3 = Ext.app.tsd.findLevel(now,3);
			//console.log('now',n_level,'target',t_level,'exist_level_2',exist_level_2,'exist_level_3',exist_level_3,'e.point',e.point);
			target.leaf=false;
			//如果当前节点为2级节点并且下面有3级节点，则不允许它移动到别的2级节点下，也不允许它移动到3级节点旁
//lvkui			if(n_level==2 && exist_level_3 && ((t_level==2 && e.point=='append') || (t_level==3))){
//				return false;
//			}
			//如果当前节点为1级节点并且下面有3级节点，则只允许它在1级节点范围内上下移动
			if(n_level==1 && exist_level_3 && (t_level!=1 || e.point=='append')){
				return false;
			}
			//如果当前节点为1级节点，则允许它移动到其他1级节点的旁边
			if(n_level==1 && (t_level==1 && e.point != 'append')){
				return true;
			}
			//如果当前节点为1级节点并且下面有2级节点，则不允许它移动到其他2级或3级节点里面
			if(n_level==1 && exist_level_2 && (t_level==2 || t_level==3)){
				if(t_level==2 && e.point != 'append')//但允许放在2级节点旁
					return true;
				else
					return false;
			}
			//这里不允许向目标是3级的节点下再继续添加子节点 
//lvkui			if(t_level==3 && e.point=='append'){
//				target.leaf=true;
//				return false;
//			}else{
		    	target.leaf=false;
		    	return true;
//			}
		});
		var nowMoveNodeInfo = {};//记录当前移动的节点的信息
		//节点移动完成进行处理
		tree.on('nodedrop',function(e){
			if (!nowMoveNodeInfo.flag) {
				var now = e.dropNode;//当前节点
				//根据节点级别修正节点样式
				Ext.app.tsd.traversingNode(now, function(n){
					n.ui.elNode.className = Ext.app.tsd.TREE_DEFAULT_STYLE[n.getDepth()];
				});
				//调用存储修正位置
				moveMenu({
					start: nowMoveNodeInfo.start,//开始序号
					end: nowMoveNodeInfo.end,//结束序号
					moveto: nowMoveNodeInfo.moveto//移动到的位置
				}, now);//当前节点
			}
		});
		//移动节点时候进行确认判断
	    tree.on('beforenodedrop',function(e){
		    var now = e.dropNode;//当前节点
			var target = e.target;//目标节点
			var flag = false;
			var nbe = Ext.app.tsd.getBeginEnd(now);//被移动节点序号信息 
			var newIndex  = 0;//移动到的位置
	    	e.preventDefault=true;
	    	e.stopPropagation=true;
	    	if(e.point=='append'){
				var t_nbe = Ext.app.tsd.getBeginEnd(target);
				//console.log('now',nbe,'target',t_nbe);
	    		if(flag = confirm('您确定将 ['+now.text+'] 放在 ['+target.text+'] 里面吗？')){
					newIndex = t_nbe.end;
					if(newIndex<nbe.end)
						newIndex++;
				}
			}else if(e.point=='above'){
				if(flag = confirm('您确定将 ['+now.text+'] 放在 ['+target.text+'] 上面吗？')){
					newIndex = Ext.app.tsd.getBeginEnd(target).begin;
					if(newIndex>nbe.end)
						newIndex--;
				}
			}else if(e.point=='below'){
				//获得本次移动的菜单的开始位置(当前节点位置)和结束位置(结束位置指到包含的最后一个子节点的位置)
				if(flag = confirm('您确定将 ['+now.text+'] 放在 ['+target.text+'] 下面吗？')){
					newIndex = Ext.app.tsd.getBeginEnd(target).end;
					if(newIndex<nbe.end)
						newIndex++;
				}
			}
			nowMoveNodeInfo = {
				start:nbe.begin,//开始序号
				end:nbe.end,//结束序号
				moveto:newIndex//移动到的位置
			};
			e.cancel = nowMoveNodeInfo.flag = !flag;//e.cancel=true 取消拖放
			if(flag==true){
				Ext.app.tsd.removeInsertFlag();//移除占位线
				btnMmfReset_click();//取消修改菜单项面板
			}
			//console.log('now',nowMoveNodeInfo);
		});
		
	    // set the root node
	    var root = new Tree.AsyncTreeNode({
	        text: 'root',
	        draggable:false,
	        id:'root'
	    });
	
	    tree.setRootNode(root);
	    // 展现菜单
		if (p_menu_type=='show') {//如果是直接展示
			tree.render();
			//tree.expandAll();
		}else if (p_menu_type=='report'){
			tree.render();
			//tree.expandAll();
		}else{//否则
			tree.hide();
			tree.render();
			//tree.animate = false;
			tree.expandAll();
			setTimeout(function(){
				tree.collapseAll();
				tree.show();
				//tree.animate = true;
			}, 2500);//这里等完全展开后再收缩
		}
		
		return tree;
	//});
};
})();