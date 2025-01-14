pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--p.craft
--by nusan
--with less token

filename,lb4,lb5,block5,time,enstep_wait,enstep_walk,enstep_chase,enstep_patrol,ao5runnumber,ao5resetnumber='statcraft_2.txt',false,false,false,0,0,1,2,3,1,0
--ao5runnumber,ao5resetnumber = 1,0

function item(n,s,p,bc)
	return {name=n,spr=s,pal=p,becraft=bc}
end

function inst(it)
	return {type=it}
end

function instc(it,c,l)
	return {type=it,count=c,list=l}
end

function setpower(v,i)
	i.power=v
	return i
end

function entity(it,xx,yy,vxx,vyy)
	return {type=it,x=xx,y=yy,vx=vxx,vy=vyy}
end

function rentity(it,xx,yy)
	return entity(it,xx,yy,rnd(3)-1.5,rnd(3)-1.5)
end

--enstep_wait,enstep_walk,enstep_chase,enstep_patrol=0,1,2,3

function settext(t,c,time,e)
	e.text,e.timer,e.c=t,time,c
	return e
end

function bigspr(spr,ent)
	ent.bigspr,ent.drop=spr,true
	return ent
end

function recipe(m,require)
	return {type=m.type,power=m.power,count=m.count,req=require,list=m.list}
end

function cancraft(req)
	for i=1,#req.req do
		if howmany(invent,req.req[i])<req.req[i].count then
			return false
		end
	end
	return true
end

--function hasalltools()
--    for i=1,#tools do
--        if howmany(invent,inst(gold)) > 0 then
--            return false
--        else
--            if howmany(invent,setpower(5,inst(tools[i]))) == 0 then
--                return false
--            end
--        end
--    end
--    return true
--end

function check_tool(power, tool)
	return howmany(invent,setpower(power, inst(tool))) > 0
end

function craft(req)
	for i=1,#req.req do
		reminlist(invent,req.req[i])
	end
	additeminlist(invent,setpower(req.power,instc(req.type,req.count,req.list)),0)
	--runstatus checks
	if check_tool(1, pick) and not woodpick then woodpick = timer_val end
	if check_tool(2, pick) and not stonepick then stonepick = timer_val end
	if check_tool(2, haxe) and check_tool(2, sword) and check_tool(2, shovel) and not stonetools then stonetools = timer_val end
	if howmany(invent, inst(factory)) > 0 and howmany(invent, inst(chem)) > 0 and not precraft then precraft = timer_val end

	--surfacetools cavetools checks
	--local newtoolscheck = stonetools and not (surfacetools and cavetools)
	--surfacetools,cavetools = currentlevel==island and newtoolscheck, currentlevel==cave and newtoolscheck
	if stonetools and not wheretools then wheretools=currentlevel.sx end
end

pwrnames,pwrpal = {"wood","stone","iron","gold","gem"},{{2,2,4,4},{5,2,4,13},{13,5,13,6},{9,2,9,10},{13,2,14,12}}

function setpal(l)
	for i=1,#l do
		pal(i,l[i])
	end
end


pstone,piron,pgold = {0,1,5,13},{1,5,13,6},{1,9,10,7}

haxe,sword,scythe,shovel,pick,wood,sand,seed,wheat,apple,glass,stone,iron,gold,gem,fabric,sail,glue,boat,ichor,potion,ironbar,goldbar,bread,workbench,stonebench,furnace,anvil,factory,chem,chest,inventary,pickuptool,etext,player,zombi = item("haxe",98),item("sword",99),item("scythe",100),item("shovel",101),item("pick",102),item("wood",103),item("sand",114,{15}),item("seed",115),item("wheat",118,{4,9,10,9}),item("apple",116),item("glass",117),item("stone",118,pstone),item("iron",118,piron),item("gold",118,pgold),item("gem",118,{1,2,14,12}),item("fabric",69),item("sail",70),item("glue",85,{1,13,12,7}),item("boat",86),item("ichor",114,{11}),item("potion",85,{1,2,8,14}),item("iron bar",119,piron),item("gold bar",119,pgold),item("bread",119,{1,4,15,7}),bigspr(104,item("workbench",89,{1,4,9},true)),bigspr(104,item("stonebench",89,{1,6,13},true)),bigspr(106,item("furnace",90,nil,true)),bigspr(108,item("anvil",91,nil,true)),bigspr(71,item("factory",74,nil,true)),bigspr(78,item("chem lab",76,nil,true)),bigspr(110,item("chest",92)),item("inventory",89),item("pickup tool",73),item("text",103),1,2

--tools = {haxe,pick,sword,shovel,scythe}

apple.givelife,potion.givelife,bread.givelife,grwater,grsand,grgrass,grfarm,grwheat,grplant,grhole = 20,100,40,{id=0,gr=0},{id=1,gr=1},{id=2,gr=2},{id=5,gr=1},{id=6,gr=1},{id=7,gr=2},{id=11,gr=1}
grrock,grtree,griron,grgold,grgem = {id=3,gr=3,mat=stone,tile=grsand,life=15},{id=4,gr=2,mat=wood,tile=grgrass,life=8,istree=true,pal={1,5,3,11}},{id=8,gr=1,mat=iron,tile=grsand,life=45,istree=true,pal={1,1,13,6}},{id=9,gr=1,mat=gold,tile=grsand,life=80,istree=true,pal={1,2,9,10}},{id=10,gr=1,mat=gem,tile=grsand,life=160,istree=true,pal={1,2,14,12}}

lastground,grounds = grsand,{grwater,grsand,grgrass,grrock,grtree,grfarm,grwheat,grplant,griron,grgold,grgem,grhole}

function cmenu(t,l,s,te1,te2)
	return {list=l,type=t,sel=1,off=0,spr=s,text=te1,text2=te2}
end

--deathmenu,winmenu = cmenu(inventary,nil,128,"you died","",""),cmenu(inventary,nil,136,"final time:","","")

function howmany(list,it)
	local count=0
	for i=1,#list do
		if list[i].type==it.type then
			if not it.power or it.power==list[i].power then
				if list[i].count then
					count+=list[i].count
				else
					count+=1
				end
			end
		end
	end
	return count
end

function isinlist(list,it)
	for i=1,#list do
		if list[i].type==it.type then
			if not it.power or it.power==list[i].power then
				return list[i]
			end
		end
	end
	return nil
end

function reminlist(list,elem)
	local it=isinlist(list,elem)
	if not it then
		return
	end
	if it.count then
		it.count-=elem.count
		if it.count<=0 then
			del(list,it)
		end
	else
		del(list,it)
	end
end

--function additeminlist(list,it,p)
--	local it2=isinlist(list,it)
--	if not it2 or not it2.count then
--		addplace(list,it,p)
--	else
--		it2.count+=it.count
--	end
--end
--
--function addplace(l,e,p)
--	if p<#l and p>0 then
--		for i=#l,p,-1 do
--			l[i+1]=l[i]
--		end
--		l[p]=e
--	else
--		add(l,e)
--	end	
--end

function additeminlist(list, it, p)
	local it2 = isinlist(list, it)
	if not it2 or not it2.count then
		if p < #list and p > 0 then
			for i = #list, p, -1 do
				list[i+1] = list[i]
			end
			list[p] = it
		else
			add(list, it)
		end
	else
		it2.count += it.count
	end
end

function isin(e,size)
	return (e.x>clx-size and e.x<clx+size and e.y>cly-size and e.y<cly+size)
end

function lerp(a,b,alpha)
	return a*(1.0-alpha)+b*alpha
end

function getinvlen(x,y)
	return 1/getlen(x,y)
end

function getlen(x,y)
	return sqrt(x*x+y*y+0.001)
end

function getrot(dx,dy)
	return dy >= 0 and (dx+3) * 0.25 or (1 - dx) * 0.25
end

function normgetrot(dx,dy)
	local l = 1/sqrt(dx*dx+dy*dy+0.001)
	return getrot(dx*l,dy*l)
end

function fillene(l)
	l.ene={entity(player,0,0,0,0)}
	enemies=l.ene
	for i=0,levelsx-1 do
		for j=0,levelsy-1 do
			local c,r,ex,ey = getdirectgr(i,j),rnd(100),i*16+8,j*16+8
			local dist = max(abs(ex-plx),abs(ey-ply))
			if r<3 and c!=grwater and c!=grrock and not c.istree and dist>50 then
				add(l.ene, {type=zombi,x=ex,y=ey,vx=0,vy=0,life=10,prot=0,lrot=0,panim=0,banim=0,dtim=0,step=0,ox=0,oy=0,id=#l.ene})
			end
		end
	end
end

function createlevel(xx,yy,sizex,sizey,isunderground)
	local l = {x=xx,y=yy,sx=sizex,sy=sizey,isunder=isunderground,ent={},ene={},dat={}}
	setlevel(l)
	levelunder = isunderground
	createmap()
	fillene(l)
	l.stx,l.sty=(holex-levelx)*16+8,(holey-levely)*16+8
	return l
end

function setlevel(l)
	currentlevel=l
	levelx,levely,levelsx,levelsy,levelunder,entities,enemies,data,plx,ply = l.x,l.y,l.sx,l.sy,l.isunder,l.ent,l.ene,l.dat,l.stx,l.sty
end

function resetlevel()
	
	reload()
	memcpy(0x1000,0x2000,0x1000)

	if runtype=="completion" then
		ao5runnumber += 1
	elseif ao5runnumber > 1 then
		ao5runnumber += 1
		ao5resetnumber += 1
	end

	if ao5resetnumber > 1 then
		ao5runnumber,ao5resetnumber = 1,0
	end

	frame_timer,runtimer,bigdiv,smalldiv,runtimer,curmenu,prot,lrot,panim,pstam,lstam,plife,llife,banim,coffx,coffy,time,woodpick,stonepick,stonetools,precraft,wheretools,ladderresets,barfull,missedhits,menutime,goldonly,cavecheck,runtype,damagetaken,heals = 0,0,1800/4096,30/4096,0,nil,0,0,0,100,100,100,100,0,0,0,0,nil,nil,nil,nil,nil,0,0,0,0,true,false,nil,0,0
	
	--lstam,plife = pstam,100

	--llife,banim,coffx,coffy,time = plife,0,0,0,0
	--woodpick,stonepick,stonetools,precraft = false,false,false,false
	--surfacetools,cavetools = false,false
	--ladderresets,barfull,missedhits,menutime = 0,0,0,0
	--goldonly,goldonlyconfirm = true,false
	--endtime = nil
	--damagetaken = 0

	tooglemenu,invent,curitem,switchlevel,canswitchlevel=0,{},nil,false,false
	menuinvent=cmenu(inventary,invent)

	--to play a set seed change it to: world_seed = yourseed --rnd(0xffff.ffff)

	--world_seed = rnd(0xffff.ffff)
	--
	--seed_str = tostr(world_seed)
	--
	--srand(world_seed)

	for i=0,15 do
		rndwat[i] = {}
		for j=0,15 do
			rndwat[i][j] = rnd(100)
		end
	end

	cave,island = createlevel(64,0,32,32,true),createlevel(0,0,64,64,false)
	--island = createlevel(0,0,64,64,false)

	--goldonly check
	for i=79, 81 do
	    for j=14, 18, 4 do
	        if mget(i, j) ~= 9 then
	            goldonly = false
	        end
	    end
	end
	for i=78, 82, 4 do
	    for j=15, 17 do
	        if mget(i, j) ~= 9 then
	            goldonly = false
	        end
	    end
	end

	--for i=78,82 do
	--	for j=14,18 do
	--		if not(i == 78 and (j == 14 or j == 18) or i == 82 and (j == 14 or j == 18)) and mget(i, j) ~= 9 then
	--			goldonly = false
	--		end
	--	end
	--end

	local tmpworkbench = entity(workbench,plx,ply,0,0)
	tmpworkbench.hascol,tmpworkbench.list=true,workbenchrecipe
	
	add(invent,tmpworkbench)
	add(invent,inst(pickuptool))

	-- cheat, to remove

	--local tmpchest = entity(chest,plx+16,ply,0,0)
	--tmpchest.hascol=true
	--tmpchest.list = {}
	--local itl = {haxe,pick,sword,shovel,scythe}
	--for i=1,#itl do
	--	for j=1,5 do
	--		add(tmpchest.list, setpower(j, inst(itl[i])))
	--	end
	--end
	--add(entities,tmpchest)

	--add(invent,instc(boat,1))
    --add(invent,instc(wood,300))
	--add(invent,instc(stone,300))
    --add(invent,instc(gem,300))
	--add(invent,instc(iron,300))
	--add(invent,instc(wheat,300))
	--add(invent,instc(gold,300))

	--runtimer=0
	--curmenu=nil
	--music(1)
	music(-1)
end

function _init()

	--cartdata("statcraft")

	--frame_timer,runtimer,bigdiv,smalldiv = 0,0,1800/4096,30/4096

	--menuitem(1, "toggle timer", function() 
	--    if dget(1) == 0 then 
	--        dset(1,1) 
	--    else 
	--        dset(1,0) 
	--    end 
	--end)

	--menuitem(1, "toggle music", function() 
	--    if dget(0) == 0 then 
	--        dset(0,1) 
	--    else 
	--        dset(0,0) 
	--    end 
	--end)

	--set_music(4,10000)

	furnacerecipe,workbenchrecipe,stonebenchrecipe,anvilrecipe,factoryrecipe,chemrecipe={},{},{},{},{},{}

	add(factoryrecipe,recipe(instc(sail,1),{instc(fabric,3),instc(glue,1)}))
	add(factoryrecipe,recipe(inst(boat),{instc(wood,30),instc(ironbar,8),instc(glue,5),instc(sail,4)}))
	
	add(chemrecipe,recipe(instc(glue,1),{instc(glass,1),instc(ichor,3)}))
	add(chemrecipe,recipe(instc(potion,1),{instc(glass,1),instc(ichor,1)}))

	add(furnacerecipe,recipe(instc(ironbar,1),{instc(iron,3)}))
	add(furnacerecipe,recipe(instc(goldbar,1),{instc(gold,3)}))
	add(furnacerecipe,recipe(instc(glass,1),{instc(sand,3)}))
	add(furnacerecipe,recipe(instc(bread,1),{instc(wheat,5)}))
	
	local tooltypes,quant,pows,materials,mult,crafter = {haxe,pick,sword,shovel,scythe},{5,5,7,7,7},{1,2,3,4,5},{wood,stone,ironbar,goldbar,gem},{1,1,1,1,3},{workbenchrecipe,stonebenchrecipe,anvilrecipe,anvilrecipe,anvilrecipe}
	--local quant = {5,5,7,7,7}
	--local pows = {1,2,3,4,5}
	--local materials = {wood,stone,ironbar,goldbar,gem}
	--local mult = {1,1,1,1,3}
	--local crafter = {workbenchrecipe,stonebenchrecipe,anvilrecipe,anvilrecipe,anvilrecipe}
	for j=1,#pows do
		for i=1,#tooltypes do
			add(crafter[j],recipe(setpower(pows[j],inst(tooltypes[i])),{instc(materials[j],quant[i]*mult[j])}))
		end
	end

	add(workbenchrecipe,recipe(instc(workbench,nil,workbenchrecipe),{instc(wood,15)}))
	add(workbenchrecipe,recipe(instc(stonebench,nil,stonebenchrecipe),{instc(stone,15)}))
	add(workbenchrecipe,recipe(instc(factory,nil,factoryrecipe),{instc(wood,15),instc(stone,15)}))
	add(workbenchrecipe,recipe(instc(chem,nil,chemrecipe),{instc(wood,10),instc(glass,3),instc(gem,10)}))
	add(workbenchrecipe,recipe(inst(chest),{instc(wood,15),instc(stone,10)}))

	add(stonebenchrecipe,recipe(instc(anvil,nil,anvilrecipe),{instc(iron,25),instc(wood,10),instc(stone,25)}))
	add(stonebenchrecipe,recipe(instc(furnace,nil,furnacerecipe),{instc(wood,10),instc(stone,15)}))

	resetlevel()
end

function getmcoord(x,y)
	return flr(x/16),flr(y/16)
end

function isfree(x,y)
	local gr = getgr(x,y)
	return not (gr.istree or gr==grrock)
end

function isfreeenem(x,y)
	local gr = getgr(x,y)
	return not (gr.istree or gr==grrock or gr==grwater)
end

function iscool(x,y)
	return not isfree(x,y)
end

function getgr(x,y)
	local i,j = getmcoord(x,y)
	return getdirectgr(i,j)
end

function getdirectgr(i,j)
	if(i<0 or j<0 or i>=levelsx or j>=levelsy) return grounds[1]
	return grounds[mget(i+levelx,j)+1]
end

function setgr(x,y,v)
	local i,j = getmcoord(x,y)
	if(i<0 or j<0 or i>=levelsx or j>=levelsy) return
	mset(i+levelx,j,v.id)
end

function dirgetdata(i,j,default)
	local g = i+j*levelsx
	if data[g]==nil then
		data[g] = default
	end
	return data[g]
end

function dirsetdata(i,j,v)
	data[i+j*levelsx] = v
end

function getdata(x,y,default)
	local i,j = getmcoord(x,y)
	if i<0 or j<0 or i>levelsx-1 or j>levelsy-1 then
		return default
	end
	return dirgetdata(i,j,default)
end

function setdata(x,y,v)
	local i,j = getmcoord(x,y)
	if i<0 or j<0 or i>levelsx-1 or j>levelsy-1 then
		return
	end
	dirsetdata(i,j,v)
end

function cleardata(x,y)
	local i,j = getmcoord(x,y)
	if i<0 or j<0 or i>levelsx-1 or j>levelsy-1 then
		return
	end
	data[i+j*levelsx] = nil
end

function loop(sel,l)
	local lp = #l
	return (((sel-1)%lp)+lp)%lp+1
end

function entcolfree(x,y,e)
	return max(abs(e.x-x),abs(e.y-y))>8
end

function reflectcol(x,y,dx,dy,checkfun,dp,e)

	--local newx,newy = x + dx,y + dy

	local ccur,ctotal,chor,cver = checkfun(x,y,e),checkfun(x + dx,y + dy,e),checkfun(x + dx,y,e),checkfun(x,y + dy,e)
	--local ctotal = checkfun(x + dx,y + dy,e)
	--local chor = checkfun(x + dx,y,e)
	--local cver = checkfun(x,y + dy,e)

	if ccur then
		if chor or cver then
			if not ctotal then
				if chor then
					dy = -dy*dp
				else
					dx = -dx*dp
				end
			end
		else
			dx=-dx*dp
			dy=-dy*dp
		end
	end

	return dx,dy
end

function additem(mat,count,hitx,hity)
	for i=1,count do
		local gi = rentity(mat,flr(hitx/16)*16 + rnd(14)+1,flr(hity/16)*16 + rnd(14)+1)
		gi.giveitem,gi.hascol,gi.timer = mat,true,110+rnd(20)
		add(entities,gi)
	end
end

function upground()

	local ci,cj = flr((clx-64)/16),flr((cly-64)/16)
	for i=ci,ci+8 do
		for j=cj,cj+8 do
			local gr = getdirectgr(i,j)
			if gr==grfarm then
				local d = dirgetdata(i,j,0)
				if time>d then
					mset(i+levelx,j,grsand.id)
				end
			end
		end
	end
end

function uprot(grot,rot)
	if abs(rot-grot) > 0.5 then 
		if rot>grot then
			grot += 1
		else
			grot -= 1
		end
	end
	return (lerp(rot, grot, 0.4)%1+1)%1
end

function txt_xpos(txt)
	return 124 - #(txt.."")*4
end

function statpack()
	stat_package = ao5runnumber.."|endtime:"..timer_val.."|precraft:"..tostr(precraft).."|stonetools:"..tostr(stonetools).."|stonepick:"..tostr(stonepick).."|woodpick:"..tostr(woodpick).."|wheretools:"..tostr(wheretools).."|barfull:"..barfull.."|missedhits:"..missedhits.."|menutime:"..menutime.."|ladderresets:"..ladderresets.."|goldonly:"..tostr(goldonly).."|cavecheck:"..tostr(cavecheck).."|damagetaken:"..damagetaken.."|heals:"..heals
end

function _update()

	if btnp(4,1) then
		if not runtype then printh("type:RESET|ao5runnumber:"..stat_package, filename) end
		resetlevel()
	end

	--add time every frame
	if runtimer == 1 then
		--should be 1/4096
		frame_timer += 1/4096

	end

	if frame_timer % bigdiv / smalldiv >= 10 then
  		zero = ""
  		d = 6
  	else
  		zero = "0"
  		d = 5
  	end
	
  	if frame_timer % smalldiv / smalldiv == 0 then 
  		e = ":000"
  	else
  		e = "00"
  	end

	timer = flr(frame_timer / bigdiv)..":"..zero..sub(tostr(frame_timer % bigdiv/smalldiv)..e, 1, d)
  	--return flr(time / (1800/4096))..":"..sub(funny, flr(time % (1800/4096)/(30/4096)) * 4 + 1, flr(time % (1800/4096)/(30/4096) * 4 + 2))


	if curmenu then
		--if curmenu == deathmenu then
		--	runtimer = 0
		--end
		if curmenu.spr then
			lb4 = btn(4)
			return
		else
			menutime += 1
			local intmenu,othmenu = curmenu,menuinvent
			--if curmenu.type==chest then
			--	if(btnp(0)) then tooglemenu-=1 sfx(18,3) end
			--	if(btnp(1)) then tooglemenu+=1 sfx(18,3) end
			--	tooglemenu=(tooglemenu%2+2)%2
			--	if tooglemenu==1 then
			--		intmenu,othmenu = menuinvent,curmenu
			--	end
			--end

			if #intmenu.list>0 then
				if(btnp(2)) then intmenu.sel-=1 sfx(18,3) end
				if(btnp(3)) then intmenu.sel+=1 sfx(18,3) end
				
				intmenu.sel = loop(intmenu.sel,intmenu.list)

				if btnp(5) and not lb5 then
					--if curmenu.type==chest then
					--	sfx(16,3)
					--	local el = intmenu.list[intmenu.sel]
					--	del(intmenu.list,el)
					--	additeminlist(othmenu.list,el,othmenu.sel)
					--	if(#intmenu.list>0 and intmenu.sel>#intmenu.list) intmenu.sel-=1
					--	if intmenu==menuinvent and curitem==el then
					--		curitem=nil
					--	end
					if curmenu.type.becraft then
						if curmenu.sel>0 and curmenu.sel<=#curmenu.list then
							local rec = curmenu.list[curmenu.sel]
							if cancraft(rec) then
								craft(rec)
								sfx(16,3)
							else
								sfx(17,3)
							end
						end
					else
						curitem = curmenu.list[curmenu.sel]
						del(curmenu.list,curitem)
						additeminlist(curmenu.list,curitem,1)
						curmenu.sel=1
						curmenu,block5=nil,true
						sfx(16,3)
					end
				end
			end
		end
		if btnp(4) and not lb4 then
			curmenu=nil
			sfx(17,3)
		end
		lb4,lb5 = btn(4),btn(5)
		statpack()
		return
	end

	if (btn(0) or btn(1) or btn(2) or btn(3) or btn(4) or btn(5)) then
        --if runtimer == 0 then
		    runtimer = 1
        --end
	end

	if switchlevel then
		if currentlevel==cave then 
			setlevel(island)
			frame_timer += 1/4096
		else
			--cavecheck check
			cavecheck = true
			setlevel(cave)
		end
		--ladderresets check
		if check_tool(2,sword) then
			ladderresets += 1
		end
		plx,ply = currentlevel.stx,currentlevel.sty
		fillene(currentlevel)
		switchlevel,canswitchlevel=false,false
		--music(currentlevel==cave and 4 or 1)
	end

	timer_val = frame_timer * 4096 / 30

	if curitem then
		if(howmany(invent,curitem)<=0) curitem=nil
	end

	upground()
	
	local playhit = getgr(plx,ply)
	if(playhit!=lastground and playhit==grwater) sfx(11,3)
	lastground = playhit
	local s = (playhit==grwater or pstam<=0) and 1 or 2
	if playhit==grhole then
		switchlevel = switchlevel or canswitchlevel
	else
		canswitchlevel = true
	end

	local dx,dy = 0,0

	if(btn(0)) dx -= 1
	if(btn(1)) dx += 1
	if(btn(2)) dy -= 1
	if(btn(3)) dy += 1

	local dl = getinvlen(dx,dy)

	dx *= dl
	dy *= dl

	if abs(dx)>0 or abs(dy)>0 then
		lrot = getrot(dx,dy)
		panim += 1/33
	else
		panim = 0
	end

	dx *= s
	dy *= s

	dx,dy = reflectcol(plx,ply,dx,dy,isfree,0)

	local canact = true

	local fin=#entities
	for i=fin,1,-1 do
		local e = entities[i]
		if e.hascol then
			e.vx,e.vy = reflectcol(e.x,e.y,e.vx,e.vy,isfree,0.9)
		end
		e.x += e.vx
		e.y += e.vy
		e.vx *= 0.95
		e.vy *= 0.95

		if e.timer and e.timer<1 then
			del(entities,e)
		else
			if(e.timer) e.timer-=1

			local dist = max(abs(e.x-plx),abs(e.y-ply))
			if e.giveitem then
				if dist<5 then
					if not e.timer or e.timer<115 then
						local newit = instc(e.giveitem,1)
						additeminlist(invent,newit,-1)
						del(entities,e)
						add(entities,settext(howmany(invent,newit),11,20,entity(etext,e.x,e.y-5,0,-1)))
						sfx(18,3)
					end
				end
			else
				if e.hascol then
					dx,dy = reflectcol(plx,ply,dx,dy,entcolfree,0,e)
				end
				if dist<12 and btn(5) and not block5 and not lb5 then
					if curitem and curitem.type==pickuptool then
						--if e.type==chest or 
						if e.type.becraft then
							additeminlist(invent,e,0)
							curitem=e
							del(entities,e)
						end
						canact = false
					else
						--if e.type==chest or 
						if e.type.becraft then
							tooglemenu=0
							curmenu = cmenu(e.type,e.list)
							sfx(13,3)
						end
						canact = false
					end
				end
			end
		end
	end

	nearenemies={}

	local ebx,eby = cos(prot),sin(prot)

	for i=1,#enemies do
		local e = enemies[i]
		if isin(e,100) then
			if e.type == player then
				e.x,e.y=plx,ply
			else
				local distp,mspeed = getlen(e.x-plx,e.y-ply),0.8

				local disten = getlen(e.x-plx - ebx*8,e.y-ply - eby*8)
				if disten<10 then
					add(nearenemies,e)
				end
				if distp<8 then
					e.ox += max(-0.4,min(0.4,e.x-plx))
					e.oy += max(-0.4,min(0.4,e.y-ply))
				end

				if e.dtim<=0 then
					if e.step==enstep_wait or e.step==enstep_patrol then
						e.step,e.dx,e.dy,e.dtim = enstep_walk,rnd(2)-1,rnd(2)-1,30+rnd(60)
						--e.step=enstep_walk
						--e.dx,e.dy = rnd(2)-1,rnd(2)-1				
						--e.dtim = 30+rnd(60)
					elseif e.step==enstep_walk then
						e.step,e.dx,e.dy,e.dtim = enstep_wait,0,0,30+rnd(60)
						--e.step=enstep_wait
						--e.dx,e.dy=0,0
						--e.dtim = 30+rnd(60)
					else -- chase
						e.dtim = 10+rnd(60)
					end
				else
					if e.step==enstep_chase then
						if distp>10 then
							e.dx += plx-e.x
							e.dy += ply-e.y
							e.banim = 0
						else
							e.dx,e.dy = 0,0
							e.banim -= 1
							e.banim = e.banim%8
							local pow = 10
							if e.banim==4 then
								plife -= pow
								--damagetaken check
								damagetaken += pow
								add(entities,settext(pow,8,20,entity(etext,plx,ply-10,0,-1)))
								sfx(14+rnd(2),3)
							end
							plife = max(0,plife)
						end
						mspeed = 1.4
						if distp>70 then
							e.step,e.dtim = enstep_patrol,30+rnd(60)
						end
					else
						if distp<40 then
							e.step,e.dtim = enstep_chase,10+rnd(60)
						end
					end
					e.dtim -= 1
				end

				local dl = mspeed*getinvlen(e.dx,e.dy)
				e.dx *= dl
				e.dy *= dl

				local fx,fy = reflectcol(e.x,e.y,e.dx+e.ox,e.dy+e.oy,isfreeenem,0)

				if abs(e.dx)>0 or abs(e.dy)>0 then
					e.lrot = getrot(e.dx,e.dy)
					e.panim += 1/33
				else
					e.panim = 0
				end

				e.x += fx
				e.y += fy

				e.ox *= 0.9
				e.oy *= 0.9

				e.prot = uprot(e.lrot,e.prot)
			end
		end
	end

	dx,dy = reflectcol(plx,ply,dx,dy,isfree,0)

	plx += dx
	ply += dy

	prot = uprot(lrot,prot)

	llife += max(-1,min(1,(plife-llife)))
	lstam += max(-1,min(1,(pstam-lstam)))
		
	if btn(5) and not block5 and canact then
		local bx,by = cos(prot),sin(prot)
		local hitx,hity = plx + bx * 8,ply + by * 8
		local hit = getgr(hitx,hity)

		if not lb5 and curitem and curitem.type.drop then
			if hit == grsand or hit == grgrass then
				
				if(not curitem.list) curitem.list={}
				curitem.hascol=true

				curitem.x,curitem.y,curitem.vx,curitem.vy = flr(hitx/16)*16+8,flr(hity/16)*16+8,0,0
				add(entities,curitem)
				reminlist(invent,curitem)
				canact = false
			end
		end

		if banim==0 and pstam>0 and canact then
			banim,stamcost = 8,20
			if #nearenemies>0 then
				sfx(19,3)
				local pow = 1
				if curitem and curitem.type==sword then
					pow,stamcost = 1+curitem.power+rnd(curitem.power*curitem.power),max(0,20-curitem.power*2)
					--stamcost = max(0,20-curitem.power*2)
					pow=flr(pow)
					sfx(14+rnd(2),3)
				else
					--missedhits check1
					missedhits += 1
				end
				for i=1,#nearenemies do
					local e = nearenemies[i]
					e.life -= pow/#nearenemies
					local push = (pow-1)*0.5
					e.ox += max(-push,min(push,e.x-plx))
					e.oy += max(-push,min(push,e.y-ply))
					if e.life<=0 then
						del(enemies,e)
						additem(ichor,rnd(3),e.x,e.y)
						additem(fabric,rnd(3),e.x,e.y)
					end
					add(entities,settext(pow,9,20,entity(etext,e.x,e.y-10,0,-1)))
				end
			elseif hit.mat then
				sfx(15,3)
				local pow = 1
				--if curitem then
				if hit==grtree then
					if curitem and curitem.type==haxe then
						pow,stamcost = 1+curitem.power+rnd(curitem.power^2),max(0,20-curitem.power*2)
						--stamcost = max(0,20-curitem.power*2)
						sfx(12,3)
					elseif check_tool(1,pick) then
						--missedhits check2
						missedhits += 1
					end			
				elseif (hit==grrock or hit.istree) and curitem then
					if curitem.type==pick then
						pow,stamcost = 1+curitem.power*2+rnd(curitem.power^2),max(0,20-curitem.power*2)
						--stamcost = max(0,20-curitem.power*2)
						sfx(12,3)
					else
						--missedhits check3
						missedhits += 1
					end
				--end
				else
					--missedhits check4
					missedhits += 1
				end
				pow=flr(pow)

				local d = getdata(hitx,hity,hit.life)
				if d-pow<=0 then
					setgr(hitx,hity,hit.tile)
					cleardata(hitx,hity)
					additem(hit.mat,rnd(3)+2,hitx,hity)
					if hit==grtree and rnd()>0.7 then
						additem(apple,1,hitx,hity)
					end
				else
					setdata(hitx,hity,d-pow)
				end
				add(entities,settext(pow,10,20,entity(etext,hitx,hity,0,-1)))
			else
				sfx(19,3)
				if curitem then
					if curitem.power then
						stamcost = max(0,20-curitem.power*2)
					end
					if curitem.type.givelife then
						plife = min(100,plife+curitem.type.givelife)
						--heals check
						heals += curitem.type.givelife
						reminlist(invent,instc(curitem.type,1))
						sfx(21,3)
					end
					if hit==grgrass and curitem.type==scythe then
						setgr(hitx,hity,grsand)
						if(rnd()>0.4) additem(seed,1,hitx,hity)
					end
					if hit==grsand and curitem.type==shovel then
						if curitem.power>3 then
							setgr(hitx,hity,grwater)
							additem(sand,2,hitx,hity)
						else
							setgr(hitx,hity,grfarm)
							setdata(hitx,hity,time+15+rnd(5))
							additem(sand,rnd(2),hitx,hity)
						end
					else
						--missedhits check5
						missedhits += 1
					end
					if hit==grwater and curitem.type==sand then
						setgr(hitx,hity,grsand)
						reminlist(invent,instc(sand,1))
					end
					if hit==grwater and curitem.type==boat then
						reload()
						memcpy(0x1000,0x2000,0x1000)
						--music(4)
						if frame_timer < 7200/4096 then
							winmenu=cmenu(inventary,nil,136,"amor fati",timer)
							--dset(0,1)
							music(7)
						--elseif frame_timer < 9000/4096 then
						--	winmenu=cmenu(inventary,nil,136,"sub 5 pog!!",timer)
						else
							winmenu=cmenu(inventary,nil,136,"final time:",timer)
						end
						--endtime check
						runtimer,curmenu,runtype = 0,winmenu,"completion"
						printh("type:COMPLETION|ao5runnumber:"..stat_package, filename)
					end
					if hit==grfarm and curitem.type==seed then
						setgr(hitx,hity,grwheat)
						setdata(hitx,hity,time+15+rnd(5))
						reminlist(invent,instc(seed,1))
					end
					if hit==grwheat and curitem.type==scythe then
						setgr(hitx,hity,grsand)
						local d = max(0,min(4,4-(getdata(hitx,hity,0)-time)))
						additem(wheat,d/2+rnd(d/2),hitx,hity)
						additem(seed,1,hitx,hity)
					end
				else
					--missedhits check6
					missedhits += 1
				end
			end
			pstam -= stamcost
		end
	end

	if banim>0 then
		banim -= 1
	end

	if pstam<100 then
		pstam = min(100,pstam+1)
	end
	--barfull check
	if pstam>=100 and runtimer==1 then
		barfull += 1
	end

	local m = 16

	if abs(cmx-plx)>m then
		coffx += dx*0.4
	end
	if abs(cmy-ply)>m then
		coffy += dy*0.4
	end

	cmx,cmy = max(plx-m,cmx),max(ply-m,cmy)
	cmx,cmy = min(plx+m,cmx),min(ply+m,cmy)

	coffx *= 0.9
	coffy *= 0.9
	coffx,coffy = min(4,max(-4,coffx)),min(4,max(-4,coffy))

	clx += coffx
	cly += coffy

	clx,cly = max(cmx-m,clx),max(cmy-m,cly)
	clx,cly = min(cmx+m,clx),min(cmy+m,cly)

	if btnp(4) and not lb4 then
		curmenu=menuinvent
		sfx(13,3)
	end

	lb4,lb5 = btn(4),btn(5)
	if not btn(5) then
		block5=false
	end

	time += 1/30

	statpack()
	--stat_package = ao5runnumber.."|endtime:"..timer_val.."|precraft:"..tostr(precraft).."|stonetools:"..tostr(stonetools).."|stonepick:"..tostr(stonepick).."|woodpick:"..tostr(woodpick).."|wheretools:"..tostr(wheretools).."|barfull:"..barfull.."|missedhits:"..missedhits.."|menutime:"..menutime.."|ladderresets:"..ladderresets.."|goldonly:"..tostr(goldonly).."|cavecheck:"..tostr(cavecheck).."|damagetaken:"..damagetaken

	if(plife<=0) then
		reload()
		memcpy(0x1000,0x2000,0x1000)
		runtimer,deathmenu = 0,cmenu(inventary,nil,128,"you died",timer)
		--deathmenu=cmenu(inventary,nil,128,"you died",timer,seed_str)
		--endtime check
		curmenu,runtype = deathmenu,"death"
		--music(4)
		printh("type:DEATH|ao5runnumber:"..stat_package, filename)
	end

  	--if dget(0) == 0 then
    --	music(-1)	
  	--end
end

function mirror(rot)
	if rot<0.125 then
		return 0,1
	elseif rot<0.325 then
	elseif rot<0.625 then
		return 1,0
	elseif rot<0.825 then
		return 1,1
	else
		return 0,1
	end
	return 0,0
end

function dplayer(x,y,rot,anim,subanim,isplayer)

	local cr,sr = cos(rot),sin(rot)
	local cv,sv = -sr,cr

	x,y = flr(x),flr(y-4)

	local lan,bel = sin(anim*2)*1.5,getgr(x,y)
	--local bel = getgr(x,y)
	if bel==grwater then
		y += 4
		circ(x + cv*3 + cr * lan,y + sv*3 + sr * lan,3,6)
		circ(x - cv*3 - cr * lan,y - sv*3 - sr * lan,3,6)
	
		local anc = 3 + ((time*3)%1)*3
		circ(x + cv*3 + cr * lan,y + sv*3 + sr * lan,anc,6)
		circ(x - cv*3 - cr * lan,y - sv*3 - sr * lan,anc,6)
	else
			
		circfill(x + cv*2 - cr * lan,y + 3 + sv*2 - sr * lan,3,1)
		circfill(x - cv*2 + cr * lan,y + 3 - sv*2 + sr * lan,3,1)
	end
		local blade = (rot+0.25)%1
		if subanim>0 then
			blade = blade - 0.3 + subanim*0.04
		end
		local bcr,bsr = cos(blade),sin(blade)

		local mx,my = mirror(blade)

		local weap = 75

		if isplayer and curitem then
			pal()
			weap=curitem.type.spr
			if curitem.power then
				setpal(pwrpal[curitem.power])
			end
			if curitem.type and curitem.type.pal then
				setpal(curitem.type.pal)
			end
		end

		spr(weap,x + bcr*4 - cr * lan - mx*8 + 1, y + bsr*4 - sr * lan + my*8 - 7,1,1,mx==1,my==1)

		if(isplayer) pal()
	
	if bel!=grwater then
		circfill(x + cv*3 + cr * lan,y + sv*3 + sr * lan,3,2)
		circfill(x - cv*3 - cr * lan,y - sv*3 - sr * lan,3,2)
		
		local my2,mx2 = mirror((rot+0.75)%1)
		spr(75,x + cv*4 + cr * lan -8+mx2*8 + 1, y + sv*4 + sr * lan + my2*8 - 7,1,1,mx2==0,my2==1)

	end
	
	circfill(x+cr,y+sr-2,4,2)
	circfill(x+cr,y+sr,4,2)
	circfill(x+cr*1.5,y+sr*1.5-2,2.5,15)
	circfill(x-cr,y-sr-3,3,4)

end

function noise(sx,sy,startscale,scalemod,featstep)

	local n = {}
	for i=0,sx do
		n[i] = {}
		for j=0,sy do
			n[i][j] = 0.5
		end
	end

	local step,scale = sx,startscale
	--local scale = startscale
	while step>1 do
		local cscal = scale
		if(step == featstep) cscal = 1
		for i=0,sx-1,step do
			for j=0,sy-1,step do
				local c1,c2,c3 = n[i][j],n[i+step][j],n[i][j+step]
				n[i+step/2][j] = (c1+c2)*0.5 + (rnd()-0.5)*cscal
				n[i][j+step/2] = (c1+c3)*0.5 + (rnd()-0.5)*cscal
			end
		end
		for i=0,sx-1,step do
			for j=0,sy-1,step do
				local c1,c2,c3,c4 = n[i][j],n[i+step][j],n[i][j+step],n[i+step][j+step]
				n[i+step/2][j+step/2] = (c1+c2+c3+c4)*0.25 + (rnd()-0.5)*cscal
			end
		end
		step /= 2
		scale *= scalemod

	end

	return n
end

level,typecount = {},{}

function createmapstep(sx,sy,a,b,c,d,e)

	local cur,cur2,cur3,cur4 = noise(sx,sy,0.9,0.2,sx),noise(sx,sy,0.9,0.4,8),noise(sx,sy,0.9,0.3,8),noise(sx,sy,0.8,1.1,4)

	for i=0,11 do
		typecount[i] = 0
	end

	for i=0,sx do
		for j=0,sy do
			local v,v2,v3,dist = abs(cur[i][j] - cur2[i][j]),abs(cur[i][j] - cur3[i][j]),abs(cur[i][j] - cur4[i][j]),max((abs(i/sx - 0.5) * 2), (abs(j/sy - 0.5) * 2))
			local coast = v*4 - dist*dist*dist*dist*4

			local id = a
			if(coast>0.3) id = b -- sand
			if(coast>0.6) id = c -- grass
			if(coast>0.3 and v2>0.5) id = d -- stone
			if(id == c and v3>0.5) id = e -- tree

			typecount[id] += 1

			cur[i][j] = id
		end
	end

	return cur
end

function createmap()

	local needmap = true

	while needmap do

		needmap = false

		if levelunder then
			level = createmapstep(levelsx,levelsy,3,8,1,9,10)

			if(typecount[8]<30) needmap = true
			if(typecount[9]<20) needmap = true
			if(typecount[10]<15) needmap = true
		else
			level = createmapstep(levelsx,levelsy,0,1,2,3,4)

			if(typecount[3]<30) needmap = true
			if(typecount[4]<30) needmap = true
		end

		if not needmap then
			plx,ply = -1,-1
			for i=0,500 do
				local depx,depy = flr(levelsx/8+rnd(levelsx*6/8)),flr(levelsy/8+rnd(levelsy*6/8))
				local c = level[depx][depy]
				if c == 1 or c == 2 then
					plx,ply = depx*16 + 8,depy*16 + 8
					break
				end
			end
			if plx < 0 then
				needmap = true
			end
		end
	end

	for i=0,levelsx-1 do
		for j=0,levelsy-1 do
			mset(i+levelx,j+levely,level[i][j])
		end
	end

	holex,holey = levelsx/2+levelx,levelsy/2+levely
	for i=-1,1 do
		for j=-1,1 do
			mset(holex+i,holey+j,((levelunder) and 1 or 3))
		end
	end
	mset(holex,holey,11)
	
	clx,cly,cmx,cmy = plx,ply,plx,ply
	
end

function comp(i,j,gr)
	local gr2 = getdirectgr(i,j)
	return (gr and gr2 and gr.gr == gr2.gr)
end

rndwat = {}

function watval(i,j)
	return rndwat[flr((i*2)%16)][flr((j*2)%16)]
end

function watanim(i,j)
	local a = ((time*0.6 + watval(i,j)/100)%1) * 19
	if(a>16) spr(a-3,i*16,j*16)
end

function rndcenter(i,j)
	return (flr(watval(i,j)/34)+18)%20
end

function rndsand(i,j)
	return flr(watval(i,j)/34)+1
end

function rndtree(i,j)
	return flr(watval(i,j)/51)*32
end

function spr4(i,j,gi,gj,a,b,c,d,off,f)
	spr(f(i,j+off)+a,gi,gj+2*off)
	spr(f(i+0.5,j+off)+b,gi+8,gj+2*off)
	spr(f(i,j+0.5+off)+c,gi,gj+8+2*off)
	spr(f(i+0.5,j+0.5+off)+d,gi+8,gj+8+2*off)
end

function panel(name,x,y,sx,sy)
	rectfill(x+8,y+8,x+sx-9,y+sy-9,1)
	spr(66,x,y)
	spr(67,x+sx-8,y)
	spr(82,x,y+sy-8)
	spr(83,x+sx-8,y+sy-8)
	sspr(24,32,4,8,x+8,y,sx-16,8)
	sspr(24,40,4,8,x+8,y+sy-8,sx-16,8)
	sspr(16,36,8,4,x,y+8,8,sy-16)
	sspr(24,36,8,4,x+sx-8,y+8,8,sy-16)

	local hx = x+(sx-#name*4)/2
	rectfill(hx,y+1,hx+#name*4,y+7,13)
	print(name,hx+1,y+2,7)
end

function itemname(x,y,it,col)
	local ty,px = it.type,x
	pal()
	if it.power then
		local pwn = pwrnames[it.power]
		print(pwn,x+10,y,col)
		px += #pwn*4 + 4
		setpal(pwrpal[it.power])
	end
	if(ty.pal) setpal(ty.pal)
	spr(ty.spr,x,y-2)
	pal()
	print(ty.name,px+10,y,col)
end

function list(menu,x,y,sx,sy,my)
	panel(menu.type.name,x,y,sx,sy)

	local tlist = #menu.list
	if tlist<1 then
		return
	end

	local sel = menu.sel
	if(menu.off>max(0,sel-4)) menu.off=max(0,sel-4)
	if(menu.off<min(tlist,sel+3)-my) menu.off=min(tlist,sel+3)-my

	sel -= menu.off

	local debut,fin = menu.off+1,min(menu.off+my,tlist)
	--local fin = min(menu.off+my,tlist)

	local sely = y+3+sel*8
	rectfill(x+1,sely,x+sx-3,sely+6,13)

	x+=5
	y+=12

	for i=debut,fin do
		local it,py,col = menu.list[i],y+(i-1-menu.off)*8,7
		--local py = y+(i-1-menu.off)*8
		--local col = 7
		if it.req and not cancraft(it) then
			col = 0
		end

		itemname(x,py,it,col)

		if it.count then
			local c = ""..it.count
			print(c,x+sx-#c*4-10,py,col)
		end
	end

	spr(68,x-8,sely)
	spr(68,x+sx-10,sely,1,1,true)
end

function requirelist(recip,x,y,sx,sy)
	panel("require",x,y,sx,sy)
	local tlist = #recip.req
	if tlist<1 then
		return
	end

	x+=5
	y+=12

	for i=1,tlist do
		local it,py = recip.req[i],y+(i-1)*8
		--local py = y+(i-1)*8
		itemname(x,py,it,7)

		if it.count then
			local h = howmany(invent,it)
			local c = h.."/"..it.count
			print(c,x+sx-#c*4-10,py,h<it.count and 8 or 7)
		end
	end
	
end

function printb(t,x,y,c)
	print(t,x+1,y,1)
	print(t,x-1,y,1)
	print(t,x,y+1,1)
	print(t,x,y-1,1)
	print(t,x,y,c)
end

function printc(t,x,y,c)
	print(t,x-#t*2,y,c)
end

function dent()
	for i=1,#entities do
		local e = entities[i]
		pal()
		if(e.type.pal) setpal(e.type.pal)
		if e.type.bigspr then
			spr(e.type.bigspr,e.x-8,e.y-8,2,2)
		else
			if e.type == etext then
				printb(e.text,e.x-2,e.y-4,e.c)
			else
				if e.timer and e.timer<45 and e.timer%4>2 then
					for i=0,15 do
						palt(i,true)
					end
				end
				spr(e.type.spr,e.x-4,e.y-4)
			end
		end
	end
end

function dbar(px,py,v,m,c,c2)
	pal()
	local pe,pe2 = px+v*0.3,px+m*0.3
	rectfill(px-1,py-1,px+30,py+4,0)
	rectfill(px,py,pe,py+3,c2)
	rectfill(px,py,max(px,pe-1),py+2,c)
	if(m>v) rectfill(pe+1,py,pe2,py+3,10)
end



function _draw()

	if curmenu and curmenu.spr then
		camera()
		palt(0,false)
		rectfill(0,0,128,46,12)
		rectfill(0,46,128,128,1)
		spr(curmenu.spr,32,14,8,8)
		printc(curmenu.text, 64,80,6)
		printc(curmenu.text2, 64,90,6)
		--printc("press button 1", 64,112,6+time%2)
		--time += 0.1
		return
	end

	cls()

	camera(clx-64, cly-64)
	
	local ci,cj = flr((clx-64)/16),flr((cly-64)/16)
	--local cj = flr((cly-64)/16)
	for i=ci,ci+8 do
		for j=cj,cj+8 do
			local gr,gi,gj = getdirectgr(i,j),(i-ci)*2 + 64,(j-cj)*2 + 32

			--local gi,gj = (i-ci)*2 + 64,(j-cj)*2 + 32

			if gr and gr.gr == 1 then -- sand
				local sv=0
				if(gr==grfarm or gr==grwheat) sv=3
				mset(gi,gj,rndsand(i,j)+sv)
				mset(gi+1,gj,rndsand(i+0.5,j)+sv)
				mset(gi,gj+1,rndsand(i,j+0.5)+sv)
				mset(gi+1,gj+1,rndsand(i+0.5,j+0.5)+sv)
			else

				local u,d,l,r,b = comp(i,j-1, gr),comp(i,j+1, gr),comp(i-1,j, gr),comp(i+1,j, gr),gr==grrock and 21 or gr==grwater and 26 or 16
	
				mset(gi,gj,b + (l and (u and (comp(i-1,j-1, gr) and 17+rndcenter(i,j) or 20) or 1) or (u and 16 or 0)) )
				mset(gi+1,gj,b + (r and (u and (comp(i+1,j-1, gr) and 17+rndcenter(i+0.5,j) or 19) or 1) or (u and 18 or 2)) )				
				mset(gi,gj+1,b + (l and (d and (comp(i-1,j+1, gr) and 17+rndcenter(i,j+0.5) or 4) or 33) or (d and 16 or 32)) )
				mset(gi+1,gj+1,b + (r and (d and (comp(i+1,j+1, gr) and 17+rndcenter(i+0.5,j+0.5) or 3) or 33) or (d and 18 or 34)) )

			end
		end
	end

	pal()
	if levelunder then
		pal(15,5)
		pal(4,1)
	end
	map(64,32,ci*16,cj*16,18,18)

	for i=ci-1,ci+8 do
		for j=cj-1,cj+8 do
			local gr = getdirectgr(i,j)
			if gr then
				local gi,gj = i*16,j*16

				pal()
					
				if gr==grwater then
					watanim(i,j)
					watanim(i+0.5,j)
					watanim(i,j+0.5)
					watanim(i+0.5,j+0.5)
				end

				if gr==grwheat then
					local d = dirgetdata(i,j,0)-time
					for pp=2,4 do
						pal(pp,3)
						if(d>(10-pp*2)) palt(pp,true)
					end
					if(d<0) pal(4,9)
					spr4(i,j,gi,gj,6,6,6,6,0,rndsand)
				end
				
				if gr.istree then
					setpal(gr.pal)
					spr4(i,j,gi,gj,64,65,80,81,0,rndtree)
				end
				
				--print(flr(srnd(3,i,j)+2),i*16,j*16,7)

				if gr==grhole then
					pal()
					if not levelunder then
						palt(0,false)
						spr(31,gi,gj,1,2)
						spr(31,gi+8,gj,1,2,true)
					end
					palt()
					spr(77,gi+4,gj,1,2)
				end
			end
		end
	end

	dent()

	for i=1,#enemies do
		local e = enemies[i]
		pal()
		if e.type == player then
			dplayer(plx,ply,prot,panim,banim,true)
		else
			if isin(e,72) then
				pal(15,3)
				pal(4,1)
				pal(2,8)
				pal(1,1)
				dplayer(e.x,e.y,e.prot,e.panim,e.banim,false)
			end
		end
	end

	camera()
	dbar(4,4,plife,llife,8,2)
	dbar(4,9,max(0,pstam),lstam,11,3)
  		
	--make timer readable
	if runtimer == 1 then

	--local funny = "00001002003004005006007008009010011012013014015016017018019020021022023024025026027028029030031032033034035036037038039040041042043044045046047048049050051052053054055056057058059060061062063064065066067068069070071072073074075076077078079080081082083084085086087088089090091092093094095096097098099100101102103104105106107108109110111112113114115116117118119120121122123124125126127128129130131132133134135136137138139140141142143144145146147148149150151152153154155156157158159160161162163164165166167168169170171172173174175176177178179180181182183184185186187188189190191192193194195196197198199200201202203204205206207208209210211212213214215216217218219220221222223224225226227228229230231232233234235236237238239240241242243244245246247248249250251252253254255256257258259260261262263264265266267268269270271272273274275276277278279280281282283284285286287288289290291292293294295296297298299300301302303304305306307308309310311312313314315316317318319320321322323324325326327328329330331332333334335336337338339340341342343344345346347348349350351352353354355356357358359360361362363364365366367368369370371372373374375376377378379380381382383384385386387388389390391392393394395396397398399400401402403404405406407408409410411412413414415416417418419420421422423424425426427428429430431432433434435436437438439440441442443444445446447448449450451452453454455456457458459460461462463464465466467468469470471472473474475476477478479480481482483484485486487488489490491492493494495496497498499500501502503504505506507508509510511512513514515516517518519520521522523524525526527528529530531532533534535536537538539540541542543544545546547548549550551552553554555556557558559560561562563564565566567568569570571572573574575576577578579580581582583584585586587588589590591592593594595596597598599600601602603604605606607608609610611612613614615616617618619620621622623624625626627628629630631632633634635636637638639640641642643644645646647648649650651652653654655656657658659660661662663664665666667668669670671672673674675676677678679680681682683684685686687688689690691692693694695696697698699700701702703704705706707708709710711712713714715716717718719720721722723724725726727728729730731732733734735736737738739740741742743744745746747748749750751752753754755756757758759760761762763764765766767768769770771772773774775776777778779780781782783784785786787788789790791792793794795796797798799800801802803804805806807808809810811812813814815816817818819820821822823824825826827828829830831832833834835836837838839840841842843844845846847848849850851852853854855856857858859860861862863864865866867868869870871872873874875876877878879880881882883884885886887888889890891892893894895896897898899900901902903904905906907908909910911912913914915916917918919920921922923924925926927928929930931932933934935936937938939940941942943944945946947948949950951952953954955956957958959960961962963964965966967968969970971972973974975976977978979980981982983984985986987988989990991992993994995996997998999"

	--timer = disp_time(frame_timer)
    --elseif runtimer == 2 then
    --pause timer
	else 
		timer = "0:00.000"
		frame_timer = 0
	end
	if not curmenu then
		ypos = 118
	else
		ypos = 40
	end

	--if dget(1) == 1 then
		if timer then
			printb(timer, txt_xpos(timer), ypos, 7)
		else 
			--printb("0:00.000", 92, ypos, 7)
		end
	--end

	if curitem then
		itemname(36,6,curitem,7)
		if curitem.count then
			print(""..curitem.count,107,6,7)
		end
	end

	if curmenu then
		camera()
		--if curmenu.type==chest then
		--	if tooglemenu==0 then
		--		list(menuinvent,87,24,84,96,10)
		--		list(curmenu,4,24,84,96,10)
		--	else
		--		list(curmenu,-44,24,84,96,10)
		--		list(menuinvent,39,24,84,96,10)
		--	end
		if curmenu.type.becraft then
			if curmenu.sel>=1 and curmenu.sel<=#curmenu.list then
				local curgoal = curmenu.list[curmenu.sel]
				panel("have",71,50,52,30)
				print(howmany(invent,curgoal),91,65,7)
				requirelist(curgoal,4,79,104,50)
			end
			list(curmenu,4,16,68,64,6)
		else
			list(curmenu,4,24,84,96,10)
		end
	end

	--local glorp,tuah = {
	--	--woodpick,
	--	--stonepick,
	--	--stonetools,
	--	--precraft,
	--	--wheretools,
	--	--ladderresets,
	--	barfull,
	--	missedhits,
	--	menutime,
	--	goldonly,
	--	goldonlyconfirm,
	--	endtime,
	--	damagetaken
	--	},1
	--for i in all(glorp) do
	--	print(i,90,tuah,8)
	--	tuah += 6
	--end

	--print(missedhits,90,1,8)

	--print(ao5runnumber,90,1,8)
	--print(ao5resetnumber,90,7,8)

	--print(stonetools,90,1,8)

	--if(true) then
	--	print("cpu "..flr(stat(1)*100),96,0,8)
	--	print("ram "..flr(stat(0)),96,8,8)
	--end

end

__gfx__
00000000ffffffffffffffffffffffffffffffff44fff44ffff44fff020121000004200002031000fff55fffffff555ff5555fff000000000001000000101000
00000000ffffffffffffffffffffffffffff444fff4ffff4ff4fffff310310200303102041420000ff56655ffff56665f56665ff000100000011100001000100
00000000fff4fffff4ffffffff4fffff4444fffffff444ff44fff44f205200024002001030310410f566665ffff566655666665f001110000110110010000100
00000000ffffffffffffff4ffffffffffffffff4ff4fff44fff44ff415340401340100402020030256666665f551566515666665000100000011100000000000
00000000ffffffffffffffffffffff4fff44444fffffffffffffffff424243032300403410140201566666655665155115666665000000000001000001100100
00000000ffffffffff4fffffffffffffffffffffff44fff444fff44f313132021240302300034104156655515666511ff1566565000000000000000000010000
00000000ffff4ffffffffffffffffffff4444fff44ff444fff444fff002021404130201204023003f155511f56651ffff1565151000000000000000000000000
00000000fffffffffffffffffffffffffffff444ffffffffffffffff001010000020100003012040ff111fff1551ffffff151f1f000000000000000000000000
fffff11ffffffffff11fffff3353333333333333ff1111ffff1111ffff1111ff6666666666666666fffff44444ffff444444ffffddddddddddddddddffffffff
fff115511fffff1115511fff3515333333333353f155551111555511115555df6666666666666666ff44444444444444444444ffddddddddddddddddfffff111
ff15533551fff155533551ff5153333333333515155555555555555555555dd166666dddddd66666f4444444444444444444444fddddddddddddddddfff11666
f15333333511153333333b1f515333333353515315556555555665555556ddd1666dddddddddd66644441111144444411444444fddddddddddddddddff166666
f15333335155515333333b1f351533333515515315556666666666666666ddd1666dddddddddd6664411ddddd111111dd144444fddddddddddddddddf116dddd
f15333351533351533333b1f33533533351535151555566666666666666dddd1666dddddddddd66641dddddddddddddddd144444dddddd1111ddddddf16ddddd
1533333353333353333333b13333515bb1533515f155566666666666666ddd1f6666ddd11ddd666641ddddddddddddddddd11444ddddd144441dddddf1dddddd
1533333333333333335333b1333335b115333353f155566666666666666ddd1f6666dd1001dd666641ddddddddddddddddddd114ddddd14ff41dddddf1dd5555
f15335333333333335153b1f333333b115533333f155566666666666666ddd1f666655100155666641dddddddddddddddddddd14ddddd144441dddddf1d55555
f1535153333333333351b1ff33333515511535331555566666666d66666dddd1666655111155666641dddddddddddddddddddd14dddd14444441ddddf1551111
ff15153333333333333b1fff35335153355331531555666665d666666666ddd16666555555556666441dddddddddddddddddd14fdddd14444441ddddf1511111
fff1533333333533333b1fff515535333333551515556666666666666666ddd16666655555566666f41dddddddddddddddddd14fddd1444114441dddf1111000
fff1533333335153333b1fff351153333333351515556666666666666666ddd16666666666666666f41dddddddddddddddddd14fdddd111dd111ddddf1110000
fff15333333335333351b1ff33551533333351531555566666665666666dddd16666666666666666441dddddddddddddddddd14fddddddddddddddddff110000
ff1515333333333335153b1f3335153333333533f15556666666d666666ddd1f666666666666666641dddddddddddddddddddd14ddddddddddddddddfff11111
f15351533333333333533b1f3333533333333333f155566666666666666ddd1f666666666666666641dddddddddddddddddddd14ddddddddddddddddffffffff
f15335333333333333333b1f3333333333533333f155566666666666666ddd1f66666666666d666641ddddddddddddddddddd114dddddddddddddddd00000000
1533333335333335333333b13333333335153333f1556666666666666666dd1f6666666665566666441dddddddddddddddd11444dddddddddddddddd00000000
1533333351533351533333b1335333533353333315556dddddd66dddddd6ddd166655666d6666666f441dddddddddddddd14444fdddddddddddddddd00000000
f1533333351bbb1533333b1f35153515333335531555ddddddddddddddddddd166d66d6666666666ff441dddddddddddd144444fdddddddddddddddd00000000
f153333333b111b333333b1f5153335335335115155dddddddddddddddddddd166666666666666d6fff4411ddd1111ddd1444fffdddddddddddddddd00000000
ff1bbb33bb1fff1b33bbb1ff353353335153355315ddddddddddddddddddddd16666666666666556fff44441114444111444ffffdddddddddddddddd00000000
fff111bb11fffff1bb111fff3335153335153333fddddd1111dddd1111dddd1f55666666666d5666ffff444444ffff444444ffffdddddddddddddddd00000000
ffffff11ffffffff11ffffff3333533333533333ff1111ffff1111ffff1111ff66d6666d66666666ffffffffffffffffffffffffdddddddddddddddd00000000
00000000222020000011111111111100001dd000000282000000770001400000000004100012022001000010000000000011a861000000000000000010101010
0000000024224200011dddddddddd11001d1110000282820000777700124006006004210012e12ee141111410000000011e1bec1009009000000000151515151
000000022422420011d1111111111d111d11111002828282007777770012441441442100122e11e1124444210000000016e1bec100400400000000115a585651
00020024244342001d111111111111d11d1111102828282807777775140122522522104112ee112241222214001100001111325100444400000001d15b5e5c51
00022024334344201d111111111111d11d1111108282828277777750124111611611142112eee1212444444202ff1000999999990040040000011dcd5b5e5c51
00024244434434201d111111111111d101d1110008282820577775000124441441444210222eee114222222422ff1000541111450024420000161ded5b5e5c51
00224334443434201d111111111111d1001dd00002828200057750000012225225222100222222102411114222220000541111450020020001676ded53525151
02344433344444201d111111111111d100000000002020000055000014111151151111411221110002444420222000005411114500222200156f6d8d55555551
02334444434444201d111111111111d11010101006111600417710211241116116111421222222220d1dd1d006666660444444440020020015666ddd52222251
24434334443344421d111111111111d1010101010061600017777142012444144144421023333332d515515d15666dd549999994002222001555555525555521
23444434444444201d111111111111d1101010100623260077771442001222522522210023333332511111150155ddd549999994001111001999999999999991
02344333444443201d111111111111d101010101623432607774142100141151151141002222222211a9e9110015dd5044444444001001001944444444444491
00234444334432001d111111111111d1101010106333336017114421001241611614210055555555119e8a110001d50055599555001111001999999999999991
012333344333221011d1111111111d11010101016233326001444210000124144142100051111115111111110001500054455445001001001544501010154451
0112222222221110011dddddddddd110101010100623260024422100000012222221000051111115156556510054210054444445001001001544510101054451
00011111111110000011111111111100010101010066600012211000000001111110000051111115011111100542121055555555000000000155101010105510
0020000000000000000000000000001100000000000011110111100000001f100222222222222220000001111100000000000000000000000000000000000000
024202000000200000002200000001410000111000001441144441000001fff10233333333333320001111565111100000066666666600000011111111111100
02442420000220000002341000001410000144410001444101111410001ffff4023333333333332001ddd1d1d1ddd10006666666677666660144444444444410
0244344422242020000244410001410000023441000234110002314101ffff41023333333333332001ddd15651ddd100166666666666666d0144999999994410
2434434442444242002324410014100000232141002321000023214119fff410023333333333332001ddd1d1d1ddd1001666666666666dd10149999999999410
24434344344444420232441002410000023201410232000002320141019f4100023333333333332001ddd15651ddd100156666666666dd100149999999999410
24434444434443202320110023200000232000102320000023200141001910000233333333333320011111d1d111110015566666666dd1000149999999999410
234444434433432032000000320000003200000032000000020000100001000002333333333333201dddd15651dddd100155666666dd10000149999999999410
023444434343322000555000000005000000400005555d5000022200000012200222222222222220155551555155551001556666ddd100000144999999994410
02324443432220000511150000505b50001242205000d6d50123432000012342055555555555555015111111111115101155556dddd400000144444444444410
00202344320000005111115005b5b735012242e2500d676d1234343200123432055555555555555015191a181a1915101445555ddd2410000155559999555510
0000023444200000511111155b73535012282efe5000d6d50123434201234321051000000000015015121812181215101412555dd21441000154445445444510
0000002433200000511111150535b5001288efe250000d051234332112343210051101010101015015115111115115100101255d210144100154445555444510
000012333211000005111115005b735001288e825000000512332232123321000510101010101150155161555161551000001242100014100154444444444510
00012222222210000055115000053500001288205000000501221121012210000511010101010150115515555515511000000141000001000155555555555510
00001111111100000000550000005000000122000555555000110010001100000510101010101150011111111111110000000111000000000011111111111100
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfcccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccf4cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccf44cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccf4ccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccf44ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77ccccccccccf4cccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777777777777777777cccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc7777777777777777777777777776666ccccccc77777cc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777777777777777777777777777665cccc777777777c
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777766777777776677777777777665ccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc7767766667776776667777777777665cccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc77cccccccccccccccccccccccccccccc7766776657776666657777777777665ccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccc777777777777cccccccccccccccccccccccccc76657765c77666665c7776777776665ccccccccccccccccc
cccccccccc7777cccccccccccccccccccccc777777777777777777cccccccccccccccccccccccccc765c7665776666654c7766777766665ccccccccccccccccc
cccccccc77777777cccccccccccccccc7777777777777777777777777cccccccccccccc777777ccc65cc765c7666565f4c776677666665cccccccccccccccccc
ccccc7777777777777cccccccccccccccccccccccccc777cccccccccccccccccccccc777777777cccccc665c6555c5f4cc766677666665cccccccccccccccccc
ccccccccccccccccc77cccccccccccccccccccccccccccccccccccccccccccccccc77777777777777ccc65cc5cccccf4ccc6657766665ccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc5ccccccccf44ccc565776665cccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfccccccccccccccccf4ccccc5cc7665ccccc77777ccccccccccc
cccccccccccccccccccccccccccccccccc666666666666666ccccccccccccccccccccccccccc2fcccccccccccccccf4cccccccc555cc7777777777777ccccccc
cccccccccccccccccccccccccccccccc666677777777776666cccccccccccccccccccccccccc24fccccccccccccccf4ccccccccccccccccccc777777777ccccc
ccccccccccccccccccccccccccccccc666666677777766666666cccccccccccccccccccccccc244fcccccccccccccf4ccc444ccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccc66655556667777666666666ccccccccccccccccccccccc2444fcccccccccccf442c2ff44cccccccccccccccccccccccccc
ccccccccccccccccccccccccccccc6651111116666666666666666cccccccccccccccccccccc22444fccccccccccf42f2ffff4cccccccccccccccccccccccccc
cccccccccccccccccccccccccccc655111111166666665555556666ccccccccccccccccccccc224444fcccccccccf4c22ffff2cccccccccccccccccccccccccc
cccccccc777777ccccccccccccc65511111116666665111111555666cccccccccccccccccccc2224444fcccccccf44c222ff222cccccccccccc333cccccccccc
ccc77777777777ccccccccccccc65111000006666651111111155556cccccccccccccccccccc222444f4fccccccf44c22222222cccccccccc3cb3bb33ccccccc
cc77777777777777cccccccccc6551100000666665111111111555555ccccccccccccccccccc22224f244fcccc7f4112222222277ccccccc3b3b534bb3c33ccc
c7777777777777777777cccccc5555100666566665111111111555555ccccccccccccccccccc2222f24444ffffff41112222f277777ccc3c3b34b355b3bb33cc
ccccccccccc777777ccccccccc5665566555156655111000001555555cccccccccccccccccccc22f244444f444447ff111112277777773b3b43b4345434b3ccc
cccccccccccccccccccccccccc56666651111566551100000055555555cccccccccc77777777724222444f244447c744ffff17777777744343343b53545344cc
cccccccccccccccccccccccccc55666651111566655100000055555555cccccccc777777777714222224f24777447c777444f222211dfff454554554554ffffd
11111111111111111111111111555555115115666555550005555555551111111111111777111122222f22777777dccc774442222211dddffffffffffffdddd1
1111111111111111111111111555555555511556666655555555555555511111111111111111112222f2777ccc777ddccc7777777711111dddddddddddd11111
111111111111111111111111575775555551555666666555555555555551111111111111111777722f277cccccc7777ddccccccccc7771117111111111111111
111111111111111111111111775765775555555555665555555555555557771111111111177cccccc227ccccccccccc77dcccccc77ccc777c7cc711111111111
1111111111111177711111116d66d667555555555555555555555555557ccc71111111177ccccccccc77cccccccccccccccccccccccccccccccd111111111111
111111111111567777111111dddddd65577555555555555555555555557ccc711111117cccccddddd77ccccdddddddccccccccccccccc7cc7ddd111111111111
1111111111115655551171111771dddd66755555555555555555577777ccccc7111117cccccdd1117ccccdd77777ccdccc77777cccccc7ccdd11111111111111
111111111111555551167711167711ddd65577555555555557777ccccccccccc1111cccdccdd1117cccdd777cccccccc777cccccccccccddd111111111111111
11111157771555555c566677156771dccdd66755555577577ccccccccccccccc111dccdcddd11117ccdd77cccccccccccccccc7ccccccdd11111111111111111
1111177755c56665cc5666677557761ddccd75555777cc7ccccccccccccccccd111dcdcdd1111111dd177ccccccccccccccc77cccccddd111111111111111111
1111776555cc6776cc556666755677511dccd7577cccccccccccccccccddddd11111ddcd11111111177cccccccccccccccc7cccccddd11111111111111111111
111776555cc566765dd55666675567511dcccc7ccccccccccccccccddd111111111111d11111111777cccccccccccdddd77cccccdd1111111111111111111111
116665555dd55677651555666775666511dccccccccccccdddccccc711111111111111111111117777cccccccdddd11117cccccdd11111111111111111111111
11665555111556676515555666715665111ddddccccccdd111dddccc711111111111111111111777ccccccccdd11111117ccccd1111111111111111111111111
175555571115556776515556666656665111111dccccd11111111dddc7711111111111111111177cccccccdd111111117ccccdd1111111111111111111111111
7c77755c77115566766115556666566651111111dcdd111111111111dccd1111111111111111777cccccdd111111111117cccd11111111111111111111111111
cccc777cccd155566765155566665666511111111d111111111111111dd1111111111111111177ccccdd11111171111117cccd11111111111111111111111111
dcccccccccd1155567661555566655555777711111111111111111111111111111111111111777cccdd1111777cd11117ccccd11111111111111111111111111
dcccc77ddd111155666611555566c5555cccc7d11111111111111111111111111111111111177ccdd111117ccccd11117cccdd11111111111111111111111111
dccccc77111111556666515555665c777cccccd1111111111111111111111111111111111117ddd1111117ccccd111117cccd111111111111111111111111111
1ddccccc711111155666611555665ddccccccd11111111111111111111111111111111111111d11111117ccccd1111111ddcd111111111111111111111111111
111dccccd1177777566665755555571dccddd11111111111111111111111111111111111111111111117ccccd1111111111dd111111111111111111111111111
1111dddd117ccccc556665c555577c777dd1111111111111111111111111111111111111111111111117cccd1111111111111111111111111111111111111111
1111111177ccccccc7555ccc7777ccccccc1111111111111111111111111111111111111111111111117cccd1111111111111111111111111111111111111111
11111117cccc77cccc777cccccccccccccd1111111111111111111111111111111111111111111111117ccd11111111111111111111111111111111111111111
11111117ccc7ccccccccccccccccccccccd1111111111111111111111111111111111111111111111117ccd11111111111111111111111111111111111111111
1111111cccdccccddd777ccccccccddddd11111111111111111111111111111111111111111111111111dd111111111111111111111111111111111111111111
1111111dcd1dccd1d7ccccccccddd111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111d11dcd111dddccccdd111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111d111111dcddd11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111d11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
__label__
3333333333333333333333333333333333333333353bbbb3b3b335533533bbbbb3bbbb53353bbbb3b3b3355333333333333333333533bbbbb3b3355ff1555666
35333335353333353533333535333335353333353535bbb3b35553355bb3b33bbb33bbb53535bbb3b355533333333333333333335bb3b33bb35551fff1556666
5153335151533351515333515153335151533351515353bb3553335153bbbb3bbbbbbb53335353bb35333333335333533333333353bbbb3b353b1fff15556ddd
35100000000000000000000000000000000bbb15351bb53bbb5bbb15353bb333bbbbb3553333353bbb5335333515351533333533353bb333bb5b1fff1555dddd
33b08888888888888888888888888888820111b333b1115b335111b33553bbbb33bb35533333515b3353515351533353333351533553bbbb335b1fff155ddddd
bb108888888888888888888888888888820fff1bbb1f15333511ff1b3153333bb3335513333315333511353335335333333335335153333b3511b1ff15dddddd
11f08888888888888888888888888888820ffff111f1555555551ff1b115555555551113333155555555133333351533333333333115555555551b1ffddddd11
fff02222222222222222222222222222220fffffffff11111111ffff1531111111111333333311111111333333335333333333333351111111113b1fff1111ff
fff00000000000000000000000000000000ffffffffffffffffffffff1533533335333333353333333333333333333333333333333533333555353b1ff5fffff
fff0bbbbbbbbbbbbbbbbbbbbbbbbbbbbb30ffffffffffffffffffffff5b555533515533335b53533333353333333333333335333351533335b55b51515b5f511
ff40bbbbbbbbbbbbbbbbbbbbbbbbbbbbb304fffffff4fffffff4fffff5bb5b533355533335bb5b53333553333353335533355333335333355b55b55355bb5b55
fff0bbbbbbbbbbbbbbbbbbbbbbbbbbbbb30ffffffffffffffffffffff5bb3bbb555b555335bb3bbb555b55533515355b555b55533335355b5bb3b53335bb3bbb
fff03333333333333333333333333333330fffffffffffffffffffff5b3bb3bbb5bbb5b55b3bb3bbb5bbb5b55155535bb5bbb5b53535515b33b3bb535b3bb3bb
fff00000000000000000000000000000000fffffffffffffffffffff5bb3b3bb3bbbbbb55bb3b3bb3bbbbbb53535b5bb3bbbbbb55155b5bbb3bb3b535bb3b3bb
ffffffffffffffffffffffffffffffffffff4fffffff4fffffff4fff5bb3bbbbb3bbb3535bb3bbbbb3bbb3533355b33bb3bbb3533555b33bbb3b3b535bb3bbbb
ffffffffffffffffffffffffffffffffffffffffffffffffffffffff53bbbbb3bb33b35353bbbbb3bb33b353353bbb33bb33b353353bbb333bbbbb5353bbbbb3
fffffffffffffffffffffffffffffffffffffffffffffffffffffffff53bbbb3b3bbbb533533bbbbb3b335533533bbbbb3bbbb53353bbbb3b3b33553353bbbb3
fffffffffffffffffffffffffffffffffffffffffffffffffffffffff535bbb3bb33bbb55bb3b33bb35553335bb3b33bbb33bbb53535bbb3b35553333535bbb3
f4ffffffff4ffffff4fffffffff4fffffff4fffff4ffffffff4fffffff5553bbbbbbbb5353bbbb3b3533333353bbbb3bbbbbbb53335353bb35533333335353bb
ffffff4fffffffffffffff4fffffffffffffffffffffff4ffffffffffff1553bbbbbb355353bb333bb533533353bb333bbbbb3533333353bbb5335533333353b
ffffffffffffff4fffffffffffffffffffffffffffffffffffffff4ffff1535b33bb35535153bbbb335351533553bbbb33bb35153333515b335351153333515b
ff4fffffffffffffff4fffffffffffffffffffffff4ffffffffffffffff11533b33355133153333b351135335153333bb3335513333315333511355333331533
ffffffffffffffffffffffffffff4fffffff4fffffffffffffffffffff1155555555111331155555555513333115555555551113333155555555133333315555
fffffffffffffffffffffffffffffffffffffffffffffffffffffffff15311111111133333311111111133333351111111111333333311111111333333331111
ffffffffffffffff555f5fffffffffffffffffffffffffffffffffff155333333333333333533333555353333353333333533333333333333333333333533333
1fffff111fffff115b55b5111fffff111fffff111fffff111fffff1155b5353333335333351533335b55b5333515333335153333333333333333333335153333
51fff15551fff1555b55b55551fff15551fff15551fff15551fff15535bb5b5333355333335333355b55b5333353333333533333335333533333333333533335
351115333515155b5bb3b5333511153335111533351115333511153335bb3bbb555b55533335355b5bb3b553333335533333355335153515333335333335355b
515551535155515b33b3bb53515551535155515351555153515551535b3bb3bbb5bbb5b53535515b33b3bb55353351153533511551533353333351533535515b
153335151535b5bbb3bb3b55153335151533351515333515153335155bb3b3bb3bbbbbb55155b5bbb3bb3b53515335535153355335335333333335335155b5bb
533333535355b33bbb3b3b53533333535333335353333353533333535bb3bbbbb3bbb3533555b33bbb3b3b53351533333515333333351533333333333555b33b
33333333353bbb333bbbbb533333333333333333333333333333333353bbbbb3bb33b353353bbb333bbbbb5333533333335333333333533333333333353bbb33
33333333353bbbb3b3bbbb5333333333333333333333333333333333353bbbb3b3b335533533bbbbb3b33553333333333333333333533333333333333533bbbb
333333333535bbb3bb33bbb5333333333333333333333333333333333535bbb3b35553335bb3b33bb3555333333333333333333335153333333333335bb3b33b
33533353335353bbbbbbbb5333333333335333533353335333533353335353bb3553333353bbbb3b353333333353335333333333335333333353335353bbbb3b
351535153333353bbbbbb355333335333515351535153515351535153333353bbb533553353bb333bb53353335153515333335333333355335153515353bb333
515333533333515b33bb3553333351535153335351533353515333533533515b335351155153bbbb33535153515333533333515335335115515333535153bbbb
3533533333331533b33355133333353335335333353353333533533351531533351135533153333b35113533353353333333353351533553353353333153333b
33351533333155555555111333333333333515333335153333351533351155555555133331155555555513333335153333333333351533333335153331155555
33335333333311111111133333333333333353333333533333335333335311111111333333311111111133333333533333333333335333333333533333311111
33533333333333333353333333333333333333333333333333333333333333333333333333533333333333333333333333333333335333335553533333533333
35153333333333333515333333333333333333333333333333333333333333333333333335153333333333333333333333333333351533335b55b53335b53533
33533333333333333353333333533353335333533353335333533353333333333333333333533333333333333333333333533353335333355b55b55335bb5b53
333335533333353333333553351535153515351535153515351535153333353333333533333335533333353333333533351535153335355b5bb3b51535bb3bbb
353351153333515335335115515333535153335351533353515333533333515333335153353351153333515333335153515333533535515b33b3bb535b3bb3bb
515335533333353351533553353353333533533335335333353353333333353333333533515335533333353333333533353353335155b5bbb3bb3b535bb3b3bb
351533333333333335153333333515333335153333351533333515333333333333333333351533333333333333333333333515333555b33bbb3b3b535bb3bbbb
33533333333333333353333333335333333353333333533333335333333333333333333333533333333333333333333333335333353bbb333bbbbb5353bbbbb3
33333333333333333333333333333333335333333333333333333333333333333333333333333333333333333333333333333333353bbbb3b3b33553353bbbb3
353333353533333535333335333333533515333335333335353333353533333535333335353333353533333533333353333333333535bbb3b35553333535bbb3
51533351515333515153335133333515515333335153335151533351515333515153335151533351515333513333351533333333335353bb35333333335353bb
351bbb15351bbb15351bbb153353515351533333351bbb15351bbb15351bbb15351bbb15351bbb15351bbb1533535153333335333333353bbb5335333333353b
33b111b333b111b333b111b3351551533515333333b111b333b111b333b111b333b111b333b111b333b111b335155153333351533533515b335351533333515b
bb1fff1bbb1fff1bbb1fff1b3515351533533533bb1fff1bbb1fff1bbb1fff1bbb1fff1bbb1fff1bbb1fff1b3515351533333533515315333511353333331533
11fffff111fffff111fffff1b15335153333515b11fffff111fffff111fffff111fffff111fffff111fffff1b153351533333333351155555555133333315555
ffffffffffffffffffffffff15333353333335b1ffffffffffffffffffffffffffffffffffffffffffffffff1533335333333333335311111111333333331111
ff1111ffff1111ffff1111fff153353335153b1fff1111ffff1111ffff1111ffff1111ffff1111ffff1111fff153353333333333335333333333333333333333
1155551111555511115555dff15351533351b1fff155551111555511115555111155551111555511115555dff153515333333333351533333333533333333333
555555555555555555555dd1ff151533333b1fff155555555555555555555555555555555555555555555dd1ff15153333333333335333353335533333533355
55566555555665555556ddd1fff15333333b1fff15556555555665555556655555566555555665555556ddd1fff15333333335333335355b555b55533515355b
66666666666666666666ddd1fff15333333b1fff15556666666666666666666444666666666666666666ddd1fff15333333351533535515bb5bbb5b55155535b
6666666666666666666dddd1fff153333351b1ff1555566666666666666666444446666666666666666dddd1fff15333333335335155b5bb3bbbbbb53535b5bb
6666666666666666666ddd1fff15153335153b1ff155566666666666666664444444666666666666666ddd1fff151533333333333555b33bb3bbb3533355b33b
6666666666666666666ddd1ff153515333533b1ff155566666666666666664444444666666666666666ddd1ff153515333333333353bbb33bb33b353353bbb33
66666666666d6666666ddd1ff153353333333b1ff155566666666666666624444444266666666666666ddd1ff153353333533333353bbbb3b3bbbb53353bbbb3
6666666665566666666dddd115333333333333b11555566666666666666222444442226666666666666dddd1f1535153351533333535bbb3bb33bbb53535bbb3
66655666d66666666666ddd115333333533333b11555666666666ddddd2222f444f2222dddd666666666ddd1ff15153333533333335353bbbbbbbb53335353bb
66d66d66666666666666ddd1f153333333333b1f15556666666ddddddd2222fffff2222dddddd6666666ddd1fff15333333335533333353bbbbbb3533333353b
66666666666666d66666ddd1f153333333333b1f15556666666ddddddd22222fff222222ddddd6666666ddd1fff15333353351153333515b33bb35153333515b
6666666666666556666dddd1ff1bbb3333bbb1ff15555666666dddddd2222222222222222dddd666666dddd1fff153335153355333331533b333551333331533
55666666666d5666666ddd1ffff111bbbb111ffff15556666666ddd11ff222222222222ff1dd6666666ddd1fff15153335153333333155555555111333315555
66d6666d66666666666ddd1fffffff1111fffffff15556666666dd101ff212222222112ff1dd6666666ddd1ff153515333533333333311111111133333331111
66666666666d666666665510ff1111ffff1111ff01556666666ddd1ff11f111222111ff111555666666ddd1ff153353355535333335333335553533333533333
666666666556666666665511115555111155551111556666666dddd1fffff1111111ffff15555666666dddd1f15351535b55b53335b535335b55b53335b53533
66655666d6666666666655555555555555555555555566666666ddd1fff1164664611fff155566666666ddd1ff1515355b55b55335bb5b535b55b55335bb5b53
66d66d6666666666666665555556655555566555555666666666ddd1ff166644446661ff155566666666ddd1fff5535b5bb3b51535bb3bbb5bb3b51535bb3bbb
66666666666666d6666666666666666666666666666666666666ddd1f116dd4dd4dd611f155566666666ddd1fff5535b33b3bb535b3bb3bb33b3bb535b3bb3bb
666666666666655666666666666666666666666666666666666dddd1f16ddd2442ddd61f15555666666dddd1fff5b5bbb3bb3b535bb3b3bbb3bb3b535bb3b3bb
55666666666d566666666666666666666666666666666666666ddd1ff1dddd2dd2dddd1ff1555666666ddd1fff55b33bbb3b3b535bb3bbbbbb3b3b535bb3bbbb
66d6666d6666666666666666666666666666666666666666666ddd1ff1dd55222255dd1ff1555666666ddd1ff53bbb333bbbbb5353bbbbb33bbbbb5353bbbbb3
666666666666666666666666666666666666666666666666666ddd1ff1d5552552555d1ff1555666666ddd1ff53bbbb3b3b335533533bbbbb3bbbb533533bbbb
6666666666666d66666666666666666666666d6666666666666dddd1f15511222211551f15555666666dddd1f535bbb3b35553335bb3b33bbb33bbb55bb3b33b
6665566665d66666666556666665566665d66666666556666666ddd1f15111111111151f155566666666ddd1ff5553bb3533333353bbbb3bbbbbbb5353bbbb3b
66d66d666666666666d66d6666d66d666666666666d66d666666ddd1f11110100101111f155566666666ddd1fff1553bbb533533353bb333bbbbb353353bb333
6666666666666666666666666666666666666666666666666666ddd1f11100111100111f155566666666ddd1fff1535b335351535153bbbb33bb35155153bbbb
666666666666566666666666666666666666566666666666666dddd1ff110010010011ff15555666666dddd1fff11533351135333153333bb33355133153333b
556666666666d66655666666556666666666d66655666666666ddd1ffff1111111111ffff1555666666ddd1fff11555555551333311555555555111331155555
66d6666d6666666666d6666d66d6666d6666666666d6666d666ddd1ffffffffffffffffff1555666666ddd1ff153111111113333333111111111133333311111
66666666666666666666666666666666666666666666666666665510ff1111ffff1111ff01556666666ddd1ff153353355535333335333333333333333333333
66666666666666666666666666666d6666666d666666666666665511115555111155551111556666666dddd1f5b555535b55b533351533333333333333333333
66655666666556666665566665d6666665d6666666655666666655555555555555555555555566666666ddd1f5bb5b535b55b553335333333353335333333333
66d66d6666d66d6666d66d66666666666666666666d66d66666665555556655555566555555666666666ddd1f5bb3bbb5bb3b515333335533515351533333533
666666666666666666666666666666666666666666666666666666666666666666666666666666666666ddd15b3bb3bb33b3bb53353351155153335333335153
66666666666666666666666666665666666656666666666666666666666666666666666666666666666dddd15bb3b3bbb3bb3b53515335533533533333333533
5566666655666666556666666666d6666666d6665566666666666666666666666666666666666666666ddd1f5bb3bbbbbb3b3b53351533333335153333333333
66d6666d66d6666d66d6666d666666666666666666d6666d66666666666666666666666666666666666ddd1f53bbbbb33bbbbb53335333333333533333333333
6666666666666666666d666666666666666666666666666666666666666666666666666666666666666ddd1ff53bbbb3b3b33553335333333333333333333333
66666d66666666666556666666666d6666666d666666666666666d666666666666666666666666666666dd1ff535bbb3b3555333351533333333333333333333
65d6666666655666d666666665d6666665d666666665566665d666666665566666666dddddd66dddddd6ddd1ff5553bb35533333335333333353335333333333
6666666666d66d6666666666666666666666666666d66d666666666666d66d66666dddddddddddddddddddd1fff1553bbb533553333335533515351533333533
6666666666666666666666d66666666666666666666666666666666666666666666dddddddddddddddddddd1fff1535b33535115353351155153335333335153
6666566666666666666665566666566666665666666666666666566666666666666dddddddddddddddddddd1fff1153335113553515335533533533333333533
6666d66655666666666d56666666d6666666d666556666666666d666556666666666ddd111dddd1111dddd1fff11555555551333351533333335153333333333
6666666666d6666d66666666666666666666666666d6666d6666666666d6666d6666dd10ff1111ffff1111fff153111111113333335333333333533333333333
666d6666666d6666666666666666666666666666666666666666666666666666666ddd1fff5ff11f555f5fff1553333333533333333333333333333333333333
65566666655666666666666666666d666666666666666d666666666666666666666dddd1f5b515515b55b5115115353335153333333333333333333333333333
d6666666d66666666665566665d666666665566665d6666666655666666556666666ddd1f5bb5b555b55b5553553315333533333333333333353335333533353
666666666666666666d66d666666666666d66d666666666666d66d6666d66d666666ddd1f5bb3bbb5bb3b5333333551533333553333335333515351535153515
666666d6666666d66666666666666666666666666666666666666666666666666666ddd15b3bb3bb33b3bb533333351535335115333351535153335351533353
6666655666666556666666666666566666666666666656666666666666666666666dddd15bb3b3bbb3bb3b553333515351533553333335333533533335335333
666d5666666d5666556666666666d666556666666666d6665566666655666666666ddd1f5bb3bbbbbb3b3b533333353335153333333333333335153333351533
666666666666666666d6666d6666666666d6666d6666666666d6666d66d6666d666ddd1f53bbbbb33bbbbb533333333333533333333333333333533333335333
66666666666666666666666666666666666d6666666d666666666666666d6666666ddd1ff53bbbb3b3b335533333333333333333333333333333333333333333
6666666666666666666666666666666665566666655666666666666665566666666dddd1f535bbb3b35553333333333333333333333333333333333333333333
ddd66dddddd66dddddd66dddddd66666d6666666d666666666655666d66666666666ddd1ff5553bb353333333333333333333333335333533333333333533353
ddddddddddddddddddddddddddddd666666666666666666666d66d66666666666666ddd1fff1553bbb5335333333353333333533351535153333353335153515
ddddddddddddddddddddddddddddd666666666d6666666d666666666666666d66666ddd1fff1535b335351533333515333335153515333533333515351533353
ddddddddddddddddddddddddddddd66666666556666665566666666666666556666dddd1fff11533351135333333111333331113151353331113153315335333
11dddd1111dddd1111dddd111ddd6666666d5666666d566655666666666d5666666ddd1fff115555555513333331777131317771717115317771713171351533
ff1111ffff1111ffff1111ff01dd6666666666666666666666d6666d66666666666ddd1ff1531111111133333331717117117171717153317171711171135333
fffffffffffffffff11ffffff1555666666d6666666d6666666d666666666666666ddd1ff1533533555353333331717131317171777133317771777177713333
1fffff111fffff1115515fff1555566665566666655666666556666666666d66666dddd1f5b555535b55b5333331717117117171117131317171717171713333
51fff15551fff155533551ff15556666d6666666d6666666d666666665d666666666ddd1f5bb5b535b55b5533351777131517771317117117771777177713333
351115333515155b555b5b5f15556666666666666666666666666666666666666666ddd1f5bb3bbb5bb3b5153515111535151115331331331113111311133553
515551535155515bb5bbb5b515556666666666d6666666d6666666d6666666666666ddd15b3bb3bb33b3bb535153335351533353333351533533511535335115
153335151535b5bb3bbbbbb51555566666666556666665566666655666665666666dddd15bb3b3bbb3bb3b533533533335335333333335335153355351533553
533333535355b33bb3bbb351f1555666666d5666666d5666666d56666666d666666ddd1f5bb3bbbbbb3b3b533335153333351533333333333515333335153333
33333333353bbb33bb33b351f155566666666666666666666666666666666666666ddd1f53bbbbb33bbbbb533333533333335333333333333353333333533333

__map__
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc4fcccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfc44ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfcc4cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc4fc4cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77cccccccccc4fcccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777777777777777777cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc7c777777777777777777777777776666cccccc7c7777cc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77777777777777777777777777776756cccc77777777c7cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc7c777767767777776776777777777766c5cccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc7c677766667767776676777777776756cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc77cccccccccccccccccccccccccccccc776677667577666656777777777766c5cccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccc777777777777cccccccccccccccccccccccccc675677567c676666c5776777776766c5cccccccccccccccccccccccccc7777cccccccccccccccccccccc777777777777777777cccccccccccccccccccccccccc67c5675677666656c4776677776666c5cccccccccccccccc
cccccccc77777777cccccccccccccccc777777777777777777777777c7cccccccccccc7c7777c7cc56cc67c5676665f5c4776677666656cccccccccccccccccccccc7c777777777777cccccccccccccccccccccccccc77c7cccccccccccccccccccc7c77777777cccccc66c556555c4fcc676677666656cccccccccccccccccc
cccccccccccccccc7cc7cccccccccccccccccccccccccccccccccccccccccccccc7c777777777777c7cc56ccc5cccc4fcc6c56776666c5ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc5ccccccfc44cc5c56776656cccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfccccccccccccccfcc4ccccc57c66c5cccc7777c7cccccccccccccccccccccccccccccccccccccccccccc66666666666666c6ccccccccccccccccccccccccccf2ccccccccccccccfcc4cccccc5c55cc777777777777c7cccccc
cccccccccccccccccccccccccccccccc666677777777776666cccccccccccccccccccccccccc42cfccccccccccccfcc4cccccccccccccccccc77777777c7cccccccccccccccccccccccccccccccccc6c66666677777766666666cccccccccccccccccccccccc42f4ccccccccccccfcc4cc44c4cccccccccccccccccccccccccc
cccccccccccccccccccccccccccccc6656556566777766666666c6cccccccccccccccccccccc4244cfcccccccccc4f242cff44cccccccccccccccccccccccccccccccccccccccccccccccccccccc6c561111116666666666666666cccccccccccccccccccccc2244f4cccccccccc4ff2f2ff4fcccccccccccccccccccccccccc
cccccccccccccccccccccccccccc56151111116666665655556566c6cccccccccccccccccccc224444cfcccccccc4f2cf2ff2fcccccccccccccccccccccccccccccccccc777777cccccccccccc6c5511111161666656111111556566cccccccccccccccccccc224244f4ccccccfc442c22ff22c2cccccccccc3c33cccccccccc
cc7c7777777777cccccccccccc6c1511000060666615111111515565cccccccccccccccccccc2242444fcfccccfc442c222222c2cccccccc3cbcb33bc3cccccccc77777777777777cccccccccc561501000066665611111111515555c5cccccccccccccccccc2222f442f4ccccf7142122222272c7ccccccb3b335b43b3cc3cc
7c777777777777777777cccccc555501606665665611111111515555c5cccccccccccccccccc22222f4444ffffff141122222f7777c7ccc3b3433b553bbb33cccccccccccc7c7777c7cccccccc655665565551665511010000515555c5cccccccccccccccccc2cf24244444f4444f71f111122777777373b4bb3345434b4c3cc
cccccccccccccccccccccccccc65666615115166551100000055555555cccccccccc7777777727242244f44244747c44ffff7177777747343443b335453544cccccccccccccccccccccccccccc55666615115166561500000055555555cccccccc7777777777412222422f747744c77747442f2212d1ff4f4555544555f4ffdf
1111111111111111111111111155555511155166565555005055555555111111111111717711112222f222777777cdcc774424222211ddfdffffffffffdfdd1d11111111111111111111111151555555551551656666555555555555551511111111111111111122222f77c7cc77d7cdcc777777771111d1dddddddddd1d1111
11111111111111111111111175755755551555656666565555555555551511111111111111717727f272c7cccc7c77d7cdcccccccc771711171111111111111111111111111111111111111177755677555555555566555555555555557577111111111171c7cccc2c72cccccccccc7cd7cccccc77cc7c777ccc171111111111
111111111111117717111111d6666d7655555555555555555555555555c7cc1711111171c7cccccccc77ccccccccccccccccccccccccccccccdc111111111111111111111111657777111111dddddd5675575555555555555555555555c7cc17111111c7ccccdddd7dc7ccdcddddddcccccccccccccc7cccd7dd111111111111
1111111111116555551117117117dddd66575555555555555555757777cccc7c111171ccccdc1d11c7ccdc7d7777cccdcc7777c7cccc7cccdd11111111111111111111111111555515617711617711dd6d557755555555557577c7cccccccccc1111ccdcccdd1171ccdc7d77cccccccc77c7ccccccccccdd1d11111111111111
1111117577515555c5656677517617cddc6d765555557775c7cccccccccccccc11d1cccddd1d1171ccdd77ccccccccccccccccc7ccccdc1d111111111111111111117177555c6656cc656676577567d1cddc57557577ccc7ccccccccccccccdc11d1dcdc1d111111dd71c7cccccccccccccc77ccccdcdd111111111111111111
1111775655cc7667cc55666657657715d1cc7d75c7ccccccccccccccccdddd1d1111dddc1111111171c7cccccccccccccc7cccccdcdd1111111111111111111111716755c55c6667d55d656676557615d1ccccc7ccccccccccccccdcdd1111111111111d1111117177ccccccccccdcdd7dc7ccccdd1111111111111111111111
11665655d55d6577565155667657665611cdccccccccccdcddcccc7c11111111111111111111117777ccccccdcdd1d1171ccccdc1d11111111111111111111111166555511516576565155656617655611d1ddcdccccdc1d11ddcdcc171111111111111111117177ccccccccdd11111171cccc1d111111111111111111111111
71555575115155766715556566666566151111d1cccc1d111111d1dd7c17111111111111111171c7ccccccdd11111111c7ccdc1d111111111111111111111111c77757c577115566671651556666656615111111cddd111111111111cddc111111111111111177c7ccccdd111111111171ccdc11111111111111111111111111
cccc77c7cc1d5565765651556666656615111111d111111111111111d11d111111111111111177ccccdd11111117111171ccdc11111111111111111111111111cdcccccccc1d515576665155656655557577171111111111111111111111111111111111117177ccdc1d117177dc1111c7ccdc11111111111111111111111111
cdcc7cd7dd1111556666115555665c55c5cc7c1d111111111111111111111111111111111171c7dc1d1111c7ccdc1111c7ccdd11111111111111111111111111cdcccc7711111155666615555566c577c7cccc1d111111111111111111111111111111111171dd1d111171cccc1d1111c7cc1d11111111111111111111111111
d1cdcccc17111151656616515566d5cdccccdc111111111111111111111111111111111111111d111111c7ccdc111111d1cd1d1111111111111111111111111111d1cccc1d71777765665657555575d1ccdd1d1111111111111111111111111111111111111111111171cccc1d11111111d11d11111111111111111111111111
1111dddd11c7cccc5566565c5575c777d71d111111111111111111111111111111111111111111111171ccdc11111111111111111111111111111111111111111111111177cccccc7c55c5cc7777cccccc1c111111111111111111111111111111111111111111111171ccdc1111111111111111111111111111111111111111
11111171cccc77cccc77c7cccccccccccc1d111111111111111111111111111111111111111111111171cc1d111111111111111111111111111111111111111111111171cc7ccccccccccccccccccccccc1d111111111111111111111111111111111111111111111171cc1d1111111111111111111111111111111111111111
111111c1cccdccdcdd77c7ccccccdcdddd11111111111111111111111111111111111111111111111111dd111111111111111111111111111111111111111111111111d1dcd1cc1d7dccccccccdd1d11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111dd1dc11d1ddccccdd1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111d1111d1dcdd11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111d111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9128002017164171721d1741a1721d1741c1621a152171720000217172151741a1721717415172191741717217102171721a174151721a17415172191741717200002171721a174171721a1721e1741e17215172
905000200b3520b35511352113550e3520e355153521035217352173551d3521d3551a3521a355213521c3520b3520b35511352113550e3520e3551535210352173551d3521a352213550b352113520e35210355
491400200b1630b3030b16300003116752d6050b1630b1630b163000000b1632d605116752d6252d6252d6250b1630b3030b16300003116752d6050b1630b1630b163000000b1632d605116750b163116750b163
911400201d1741c1621a1521e1741d1741c1621a1521c1621a1521d1741c1621a1521d1741c1621a152171721d104171721515218174151741716215174171620e10217172151521817417162151521716215152
492800200b1550b30511155113050e1550e30515155103050b5750b50511575115050e5750e505155751c3050b1550b30511155113050e1550e30515155105050b5750b50511575115050e5750e5051557510305
902800201d07024070240721d07024070240721d07024070240721607015070160751607516075210701d07024070240721d07024070240721d07024070240721607015070160751607516075210702207021072
9528002023134211312113221135291342a1312a1322a135261342813128132281352d1342e1312e1322e13523134211312113221135291342a1312a1322a135261342813128132281352d1342e1312e1322e135
485000000b1751217211175101720e17516172151750917217575125721d5751c5721a5752257221575155720b1751217211175101720e17516172151750917217575125721d5751c5721a575225722157528572
90140020346451c6751c6551c665346151062510645106351c675106551064510665346151062510635106453464534675346551c665346151c6251c6451c6351c6751c6553464534665346151c6251c63534645
90140020346451c6051c6051c605346151060510605106051c675106051060510605346151060510605106053464534605346051c605346151c6051c6051c6051c6751c6053460534605346151c6051c60534645
48040000066200c62012630156301564012650106500e6500d6500b6500a6500965007650076500c6500f6501065010640106400f6300f6300f6300f6300c6300a62009620096200861003610036100262000000
0001000006620136501a6603f0703f0701867013660106400c6300a62007610056100160000600006000260027600016000260019600026000260002600026000160002600016000160002600036000360001600
480100000000016570255702d57038570385700000000000000001750000000105000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
480100000f7600f7602d6602d66037660346602b6602666026650296502165027650296501e6401c64022630346202e62033630356202e620236302063023630296202f620336103561030610296102760000000
4801000012760127601e660256603066033660346603066027660226502465025650226501f650186501a6501764014640136401163010630106300f6300f6200f6101061010610106100d610086000000000000
4801000019000361303617036170361703616036150361503614036130361103611035110351102e3702e3602e3502e3402e3302e3202e3103310033100331003310032100321003210032100321003210032100
480100001227003270032700327003270032700327003270032700327003270032700327002270022700227003270032600327003260042700426004250042500424005240052300623007220072100000000000
48010000000003a330373603437000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
48010000000001262012620126301263011640106500f6500f6500f6500e6500e6500e6500e6500e6500e6500d6500d6500d6500d6500c6500c6400b6300b6300a6200a6200a6100961009600000000000000000
48010000114200e4200f4201143013430144401645031450304601c4601e4601f4703947024470294702f4703047027570295702c5702f5203251022570235700000000000000000000000000000000000000000
48020000000000e4700e4701147013470184701b4701d470114701247017470194701c47020470000001c4601f46024460274702947000000204402345027450294702a470014001d4601e46021440274302e420
015000200c555095621d055105520e55516552155550957217565125721d5751c5721a5751655215555105520c555095621d055105520e55516552155550957217565125721d5751c5721a57516552115551f552
005000201d555095621d055105520e55516552155550957217565125721d5751c5721a5751655215555105520c555095621d055105520e55516552155550957217565125721d5751c5721a57516552115551f552
48140020006650b3030065500003156652d60500665016650065500005006552d605116652d6252d6252d625006650b3030065500003156652d60500665016650065500000006552d60511665006551166500655
015000201e5550a5621e055115520f55517552165550a5620d575165621e5651d5621b5651755216555115520d5550a5621e055115520f55517552165550a5620d575165621e5651d5621b565175521255520552
902800201e07025070250721e07025070250721e07025070250721707016070170751707517075220701e07025070250721e07025070250721e07025070250721707016070170751707517075220702307022072
0050002018555095621d055105520e55516552155550956217555125621d5651c5621a5651655215555105520c555095621d055105520e55516552155550956217555125621d5651c5621a56516552115551f552
912800001e07025070250721e0701e0721c0701c07218070250002500025000250001e0001e0001e0001e0001e0001e0001e0001e0001c0001c0001c0001c0001c0001c0001c0001c00018000180001800018000
015000001e5550a5520d555105521e5001e5001e5001e5000a5000a5000a5000a5000a5000a5000a5000a5000d5000d5000d5000d5000d5000d5000d5000d5001050010500105001050010500105001050010500
490a000000600000001260012600156001360000600000000060000000000000000015600000000060000000006000000000000000001560000000006000000011600000002d600000002d600000002d60000000
000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010d00000a270002000d27011270022000a2700d27003200112700a2700a2500927008270062000c2701227008200082700c27012200122700f2700f2500c2700d2700d20011270142700e2000d270112700f200
010d00001427011270112500f2700c270112001127014270142501127016270162501427014250142500f2700a270002000d27011270002000a2700d270002000000000000000000000000000000000000000000
011000001e1501e1501e1501e1501e1501e1501e1501e150231502315023150231502315023150231502615026150261502615026150261502615026150261502615028150281502815000100000000000000000
__music__
00 44024344
01 01020344
00 44020344
02 04050344
01 47084944
01 07080a44
02 07480944
00 06565744
00 06164344
00 06171844
01 06171844
00 1a191844
00 1a191844
00 1e1c1d18
02 06161844
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
01 32424344
02 33424344

